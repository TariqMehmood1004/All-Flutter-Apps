import 'dart:async';
import 'dart:ui';
import 'package:app/db/biometric_storage_data.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_screen/flutter_secure_screen.dart';
import 'dart:io';
import 'account_credentials.dart';
import 'account_settings.dart';
import 'common.dart';
import 'entry_event.dart';
import 'entry_type.dart';
import 'history.dart';
import 'host_address.dart';
import 'id_card.dart';
import 'identity.dart';
import 'images.dart';
import 'note.dart';
import 'password.dart';
import 'bytes.dart';
import 'entry.dart';
import 'payment_card.dart';
import 'screen.dart';
import 'synchronization.dart';

class LoadedAccount {
  final AccountCredentialsFile _credentials;
  final AccountSettingsFile _settings;
  final HistoryFile _history;
  final PasswordsFile _passwords;
  final Images _passwordIcons;
  final NotesFile _notes;
  final PaymentCardsFile _paymentCards;
  final IDCardsFile _idCards;
  final IdentitiesFile _identities;
  Encrypter _encrypter;

  LoadedAccount({
    required String path,
    required Encrypter encrypter,
    AccountCredentialsFile? credentials,
    AccountSettingsFile? settings,
    HistoryFile? history,
    PasswordsFile? passwords,
    Images? passwordIcons,
    NotesFile? notes,
    PaymentCardsFile? paymentCards,
    IDCardsFile? idCards,
    IdentitiesFile? identities,
  })  : _encrypter = encrypter,
        _credentials = credentials ??
            AccountCredentials.fromFile(
                File('$path${Platform.pathSeparator}credentials.json')),
        _settings = settings ??
            AccountSettings.fromFile(
                File('$path${Platform.pathSeparator}settings.enc'),
                encrypter: encrypter),
        _history = history ??
            History.fromFile(File('$path${Platform.pathSeparator}history.enc'),
                encrypter: encrypter),
        _passwords = passwords ??
            Passwords.fromFile(
                File('$path${Platform.pathSeparator}passwords.enc'),
                encrypter: encrypter),
        _passwordIcons = passwordIcons ??
            Images('$path${Platform.pathSeparator}password_icons',
                encrypter: encrypter),
        _notes = notes ??
            Notes.fromFile(File('$path${Platform.pathSeparator}notes.enc'),
                encrypter: encrypter),
        _paymentCards = paymentCards ??
            PaymentCards.fromFile(
                File('$path${Platform.pathSeparator}payment_cards.enc'),
                encrypter: encrypter),
        _idCards = idCards ??
            IDCards.fromFile(File('$path${Platform.pathSeparator}id_cards.enc'),
                encrypter: encrypter),
        _identities = identities ??
            Identities.fromFile(
                File('$path${Platform.pathSeparator}identities.enc'),
                encrypter: encrypter) {
    if (Platform.isAndroid) {
      FlutterSecureScreen.singleton
          .setAndroidScreenSecure(_settings.value.protectScreen);
    }
  }

  void setAccountPassword(String password) {
    _credentials.value.password = password;
    _encrypter = getEncrypter(password);
    _settings.encrypter = _encrypter;
    _history.encrypter = _encrypter;
    _passwords.encrypter = _encrypter;
    _passwordIcons.encrypter = _encrypter;
    _notes.encrypter = _encrypter;
    _paymentCards.encrypter = _encrypter;
    _idCards.encrypter = _encrypter;
    _identities.encrypter = _encrypter;
  }

  Future<void> save() => Future.wait([
        _credentials.save(),
        _settings.save(),
        _history.save(),
        _passwords.save(),
        _passwordIcons.save(),
        _notes.save(),
        _paymentCards.save(),
        _idCards.save(),
        _identities.save(),
      ]);

  void saveSync() {
    _credentials.saveSync();
    _settings.saveSync();
    _history.saveSync();
    _passwords.saveSync();
    _passwordIcons.saveSync();
    _notes.saveSync();
    _paymentCards.saveSync();
    _idCards.saveSync();
    _identities.saveSync();
  }

  Synchronization getSynchronization({
    void Function()? onConnected,
    void Function()? onComplete,
    void Function(String log)? onError,
  }) =>
      Synchronization(this,
          history: _history.value,
          encrypter: _encrypter,
          onComplete: onComplete,
          onError: onError);

  Future<HostAddress?> host({
    void Function()? onConnected,
    void Function()? onComplete,
    void Function(String log)? onError,
  }) =>
      getSynchronization(
              onConnected: onConnected,
              onComplete: onComplete,
              onError: onError)
          .host(onConnected: onConnected);

  Future<void> connect(
    HostAddress address, {
    void Function()? onConnected,
    void Function()? onComplete,
    void Function(String log)? onError,
  }) {
    onConnected?.call();
    return getSynchronization(
            onConnected: onConnected, onComplete: onComplete, onError: onError)
        .connect(address);
  }

  void Function(Entry value) setEntry(EntryType type) {
    switch (type) {
      case EntryType.password:
        return (Entry value) => setPassword(value as Password);
      case EntryType.passwordIcon:
        return (Entry value) => setPasswordIcon(value as Bytes);
      case EntryType.paymentCard:
        return (Entry value) => setPaymentCard(value as PaymentCard);
      case EntryType.note:
        return (Entry value) => setNote(value as Note);
      case EntryType.idCard:
        return (Entry value) => setIDCard(value as IDCard);
      case EntryType.identity:
        return (Entry value) => setIdentity(value as Identity);
      default:
        throw Exception('Unsupported entry type \'${type.name}\'');
    }
  }

  Entry? Function(String key) getEntry(EntryType type) {
    switch (type) {
      case EntryType.password:
        return getPassword;
      case EntryType.passwordIcon:
        return getPasswordIcon;
      case EntryType.paymentCard:
        return getPaymentCard;
      case EntryType.note:
        return getNote;
      case EntryType.idCard:
        return getIDCard;
      case EntryType.identity:
        return getIdentity;
      default:
        throw Exception('Unsupported entry type \'${type.name}\'');
    }
  }

  void Function(String key) removeEntry(EntryType type) {
    switch (type) {
      case EntryType.password:
        return removePassword;
      case EntryType.passwordIcon:
        return removePasswordIcon;
      case EntryType.paymentCard:
        return removePaymentCard;
      case EntryType.note:
        return removeNote;
      case EntryType.idCard:
        return removeIDCard;
      case EntryType.identity:
        return removeIdentity;
      default:
        throw Exception('Unsupported entry type \'${type.name}\'');
    }
  }

  // Account Credentials wrappers
  String get username => _credentials.value.username;
  set username(String value) => _credentials.value.username = value;
  String get passwordHash => _credentials.value.passwordHash;
  bool get bioAuthEnabled => _credentials.value.bioAuthEnabled;
  set bioAuthEnabled(bool value) => _credentials.value.bioAuthEnabled = value;
  Future<void> saveCredentials() => _credentials.save();
  void saveCredentialsSync() => _credentials.saveSync();

  // Account Settings wrappers
  String get icon => _settings.value.icon;
  set icon(String value) => _settings.value.icon = value;
  Color get color => _settings.value.color;
  set color(Color value) => _settings.value.color = color;
  Screen get defaultScreen => _settings.value.defaultScreen;
  set defaultScreen(Screen value) => _settings.value.defaultScreen = value;
  Future<void> saveSettings() => _settings.save();
  bool get protectScreen => _settings.value.protectScreen;
  set protectScreen(bool value) => _settings.value.protectScreen = value;
  void saveSettingsSync() => _settings.saveSync();

  Future<BiometricStorageData> get biometricStorageData =>
      BiometricStorageData.fromLocker(_credentials.value.username);

  // History wrappers
  void clearRemovedHistory() => _history.value.clearRemoved();
  void renewHistory() => _history.value.renew();
  Future<void> saveHistory() => _history.save();
  void saveHistorySync() => _history.saveSync();

  // Passwords wrappers
  Iterable<Password> get passwords => _passwords.value.entries;

  Password? getPassword(String key) => _passwords.value.getEntry(key);

  void setPassword(Password password) {
    _history.value.passwords[password.key] = EntryEvent(password.key,
        status: EntryStatus.alive, lastModified: DateTime.now().toUtc());
    _passwords.value.setEntry(password);
  }

  void removePassword(String key) {
    _history.value.passwords[key]!
      ..status = EntryStatus.removed
      ..lastModified = DateTime.now().toUtc();
    _passwords.value.removeEntry(key);
  }

  Future<void> savePasswords() async {
    await _passwords.save();
    await _history.save();
  }

  void savePasswordsSync() {
    _passwords.saveSync();
    _history.saveSync();
  }

  // Password Icons wrappers
  Bytes? getPasswordIcon(String name) => _passwordIcons.getEntry(name);

  void setPasswordIcon(Bytes passwordIcon) {
    _history.value.passwordIcons[passwordIcon.key] = EntryEvent(
        passwordIcon.key,
        status: EntryStatus.alive,
        lastModified: DateTime.now().toUtc());
    _passwordIcons.setEntry(passwordIcon);
  }

  void removePasswordIcon(String key) {
    _history.value.passwordIcons[key]!
      ..status = EntryStatus.removed
      ..lastModified = DateTime.now().toUtc();
    _passwordIcons.removeEntry(key);
  }

  Future<void> savePasswordIcons() async {
    await _passwordIcons.save();
    await _history.save();
  }

  void savePasswordIconsSync() {
    _passwordIcons.saveSync();
    _history.saveSync();
  }

  // Notes wrappers
  Iterable<Note> get notes => _notes.value.entries;

  Note? getNote(String key) => _notes.value.getEntry(key);

  void setNote(Note note) {
    _history.value.notes[note.key] = EntryEvent(
      note.key,
      status: EntryStatus.alive,
      lastModified: DateTime.now().toUtc(),
    );
    _notes.value.setEntry(note);
  }

  void removeNote(String key) {
    _history.value.notes[key]!
      ..status = EntryStatus.removed
      ..lastModified = DateTime.now().toUtc();
    _notes.value.removeEntry(key);
  }

  Future<void> saveNotes() async {
    await _notes.save();
    await _history.save();
  }

  void saveNotesSync() {
    _notes.saveSync();
    _history.saveSync();
  }

  // Payment Cards wrappers
  Iterable<PaymentCard> get paymentCards => _paymentCards.value.entries;

  PaymentCard? getPaymentCard(String key) => _paymentCards.value.getEntry(key);

  void setPaymentCard(PaymentCard paymentCard) {
    _history.value.paymentCards[paymentCard.key] = EntryEvent(
      paymentCard.key,
      status: EntryStatus.alive,
      lastModified: DateTime.now().toUtc(),
    );
    _paymentCards.value.setEntry(paymentCard);
  }

  void removePaymentCard(String key) {
    _history.value.paymentCards[key]!
      ..status = EntryStatus.removed
      ..lastModified = DateTime.now().toUtc();
    _paymentCards.value.removeEntry(key);
  }

  Future<void> savePaymentCards() async {
    await _paymentCards.save();
    await _history.save();
  }

  void savePaymentCardsSync() {
    _paymentCards.saveSync();
    _history.saveSync();
  }

  // ID Cards wrappers
  Iterable<IDCard> get idCards => _idCards.value.entries;

  IDCard? getIDCard(String key) => _idCards.value.getEntry(key);

  void setIDCard(IDCard idCard) {
    _history.value.idCards[idCard.key] = EntryEvent(
      idCard.key,
      status: EntryStatus.alive,
      lastModified: DateTime.now().toUtc(),
    );
    _idCards.value.setEntry(idCard);
  }

  void removeIDCard(String key) {
    _history.value.idCards[key]!
      ..status = EntryStatus.removed
      ..lastModified = DateTime.now().toUtc();
    _idCards.value.removeEntry(key);
  }

  Future<void> saveIDCards() async {
    await _idCards.save();
    await _history.save();
  }

  void saveIDCardsSync() {
    _idCards.saveSync();
    _history.saveSync();
  }

  // Identities wrappers
  Iterable<Identity> get identities => _identities.value.entries;

  Identity? getIdentity(String key) => _identities.value.getEntry(key);

  void setIdentity(Identity identity) {
    _history.value.identities[identity.key] = EntryEvent(
      identity.key,
      status: EntryStatus.alive,
      lastModified: DateTime.now().toUtc(),
    );
    _identities.value.setEntry(identity);
  }

  void removeIdentity(String key) {
    _history.value.identities[key]!
      ..status = EntryStatus.removed
      ..lastModified = DateTime.now().toUtc();
    _identities.value.removeEntry(key);
  }

  Future<void> saveIdentities() async {
    await _identities.save();
    await _history.save();
  }

  void saveIdentitiesSync() {
    _identities.saveSync();
    _history.saveSync();
  }
}
