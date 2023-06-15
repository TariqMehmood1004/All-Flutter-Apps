// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:app/db/legacy.dart';
import 'package:encrypt/encrypt.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'account_credentials.dart';
import 'info.dart';
// import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';

import 'common.dart';
import 'loaded_account.dart';

class Data {
  final InfoFile info;
  bool get noAccounts => _accounts.isEmpty;
  Iterable<String> get usernames => _accounts.keys;
  Map<String, String> get passwordHashes =>
      _accounts.map((key, value) => MapEntry(key, value.value.passwordHash));
  LoadedAccount? get loadedAccount => _loadedAccount;

  // ignore: non_constant_identifier_names
  final String Path;
  final String accountsPath;
  final Map<String, AccountCredentialsFile> _accounts = {};
  LoadedAccount? _loadedAccount;

  String? getPasswordHash(String username) =>
      _accounts[username]?.value.passwordHash;
  bool? getBioAuthEnabled(String username) =>
      _accounts[username]?.value.bioAuthEnabled;
  void setBioAuthEnabledSync(String username, bool value) {
    _accounts[username]?.value.bioAuthEnabled = value;
    _accounts[username]?.saveSync();
  }

  bool hasAccount(String username) => _accounts.containsKey(username);

  Data(String path)
      : Path = path,
        accountsPath = '$path${Platform.pathSeparator}accounts',
        info = Info.fromFile(File('$path${Platform.pathSeparator}.json')) {
    if (info.value.version != Version) {
      info.value.version = Version;
      info.saveSync();
    }
    refeshAccounts();
    if (!_accounts.containsKey(info.value.lastUsername)) {
      if (_accounts.isEmpty) {
        info.value.lastUsername = '';
      } else {
        info.value.lastUsername = _accounts.keys.first;
      }
      info.saveSync();
    }
  }

  void refeshAccounts() {
    _accounts.clear();
    Directory accountsDirectory =
        Directory('$Path${Platform.pathSeparator}accounts');
    accountsDirectory.createSync(recursive: true);
    List<FileSystemEntity> accountDirectories = accountsDirectory.listSync();
    for (FileSystemEntity d in accountDirectories) {
      String username = d.path.split(Platform.pathSeparator).last;
      _accounts[username] = AccountCredentials.fromFile(
        File(
            '$accountsPath${Platform.pathSeparator}$username${Platform.pathSeparator}credentials.json'),
        value: AccountCredentials(username: username, password: 'corrupted'),
      );
    }
  }

  void createAccount(String username, String password) {
    String accountPath = accountsPath + Platform.pathSeparator + username;
    AccountCredentialsFile file = AccountCredentials.fromFile(
        File('$accountPath${Platform.pathSeparator}credentials.json'),
        value: AccountCredentials(username: username, password: password));
    File('$accountPath${Platform.pathSeparator}version.txt')
      ..createSync()
      ..writeAsStringSync(accountVersion);
    _accounts[username] = file;
    LoadedAccount(
      path: accountPath,
      credentials: file,
      encrypter: getEncrypter(password),
    );
  }

  void _removeAccount(String username) {
    if (_loadedAccount != null) {
      if (_loadedAccount!.username == username) {
        _loadedAccount = null;
      }
    }
    _accounts.remove(username);
    if (_accounts.isEmpty) {
      info.value.lastUsername = '';
      return;
    }
    info.value.lastUsername = _accounts.keys.first;
  }

  Future<void> removeAccount(String username) {
    _removeAccount(username);
    return Future.wait([
      info.save(),
      Directory(accountsPath + Platform.pathSeparator + username)
          .delete(recursive: true),
    ]);
  }

  void removeAccountSync(String username) {
    _removeAccount(username);
    info.saveSync();
    Directory(accountsPath + Platform.pathSeparator + username)
        .deleteSync(recursive: true);
  }

  LoadedAccount loadAccount(String username, Encrypter encrypter) {
    _loadedAccount = convertLegacyAccount(
      path: accountsPath + Platform.pathSeparator + username,
      encrypter: encrypter,
      credentials: _accounts[username],
    );
    return _loadedAccount!;
  }

  void unloadAccount() => _loadedAccount = null;

  void backupAccount(String username, String outputDirectoryPath) {
    //
    var encoder = ZipFileEncoder();
    String accountPath = accountsPath + Platform.pathSeparator + username;
    encoder.create(
        '$outputDirectoryPath${Platform.pathSeparator}-backup-$username-${DateTime.now().toIso8601String().replaceAll(':', ';')}.zip');
    encoder.addDirectory(Directory(accountPath));
    encoder.close();
  }

  Future<LoadedAccount> restoreAccount(String backupPath,
      {required Encrypter encrypter}) async {
    String tempPath =
        '${(await getTemporaryDirectory()).path}${Platform.pathSeparator}-restore-${DateTime.now().toIso8601String().replaceAll(':', ';')}';
    Directory tempPathDir = Directory(tempPath);
    if (await tempPathDir.exists()) {
      await tempPathDir.delete(recursive: true);
    }
    await tempPathDir.create(recursive: true);
    String username;
    String tempAccountPath;
    String newAccountPath;
    Directory newAccountDir;
    ZipDecoder decoder = ZipDecoder();
    Archive archive = decoder.decodeBytes(await File(backupPath).readAsBytes());
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        await File(tempPath + Platform.pathSeparator + filename)
            .create(recursive: true)
            .then((value) => value.writeAsBytes(data));
      } else {
        await Directory(tempPath + Platform.pathSeparator + filename)
            .create(recursive: true);
      }
    }
    username = archive.first.name.split('/')[0];
    tempAccountPath = tempPath + Platform.pathSeparator + username;
    {
      LoadedAccount account =
          convertLegacyAccount(path: tempAccountPath, encrypter: encrypter);
      account.bioAuthEnabled = false;
      account.clearRemovedHistory();
      account.renewHistory();
      account.saveSync();
    }
    // Able to load the account, safe to replace
    newAccountPath = accountsPath + Platform.pathSeparator + username;
    newAccountDir = Directory(newAccountPath);
    unloadAccount();
    if (await newAccountDir.exists()) {
      await newAccountDir.delete(recursive: true);
    }
    await newAccountDir.create(recursive: true);
    await copyDirectory(
      Directory(tempAccountPath),
      newAccountDir,
    );
    refeshAccounts();
    await tempPathDir.delete(recursive: true);
    return LoadedAccount(path: newAccountPath, encrypter: encrypter);
  }

  Future<void> changeAccountUsername(
      String username, String newUsername) async {
    if (newUsername.length < 2) throw 'Username is shorter than 2 letters';
    if (_accounts.containsKey(newUsername)) throw 'Username is already in use';
    AccountCredentials creds;
    {
      AccountCredentialsFile credsFile = _accounts[username]!;
      creds = credsFile.value;
      _accounts.remove(username);
      credsFile.value.username = newUsername;
      await credsFile.save();
    }
    await Directory(
            '$Path${Platform.pathSeparator}accounts${Platform.pathSeparator}$username')
        .rename(
            '$Path${Platform.pathSeparator}accounts${Platform.pathSeparator}$newUsername');
    _accounts[newUsername] = AccountCredentialsFile(
        File(
          '$Path${Platform.pathSeparator}accounts${Platform.pathSeparator}$newUsername${Platform.pathSeparator}credentials.json',
        ),
        value: creds);
    info.value.lastUsername = newUsername;
    await info.save();
  }
}
