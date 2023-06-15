// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'dart:io';

import 'common.dart';
import 'entry_event.dart';
import 'entry_type.dart';
import 'history.dart';
import 'host_address.dart';
import 'json_convertable.dart';
import 'loaded_account.dart';
import 'entry.dart';
import 'stream_subscription.dart';

const String _hello = 'hello';
const String _sameHistoryHash = 'same';

class _EntryData with JsonConvertable {
  final String key;
  final EntryType type;
  final EntryEvent event;
  final List<dynamic>? value;

  _EntryData({
    required this.key,
    required this.type,
    required this.event,
    this.value,
  });

  _EntryData.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        type = entryTypeFromName(json['type'])!,
        event = EntryEvent.fromJson(json['event']),
        value = json['entry'];

  @override
  Map<String, dynamic> toJson() => {
        'key': key,
        'type': type.name,
        'event': event.toJson(),
        'entry': value,
      };
}

class _Request with JsonConvertable {
  final List<String> passwords;
  final List<String> passwordIcons;
  final List<String> notes;
  final List<String> paymentCards;
  final List<String> idCards;
  final List<String> identities;
  int get length =>
      passwords.length +
      passwordIcons.length +
      notes.length +
      paymentCards.length +
      idCards.length +
      identities.length;

  _Request({
    List<String>? passwords,
    List<String>? passwordIcons,
    List<String>? notes,
    List<String>? paymentCards,
    List<String>? idCards,
    List<String>? identities,
  })  : passwords = passwords ?? [],
        passwordIcons = passwordIcons ?? [],
        notes = notes ?? [],
        paymentCards = paymentCards ?? [],
        idCards = idCards ?? [],
        identities = identities ?? [];

  _Request.fromJson(Map<String, dynamic> json)
      : passwords = (json['passwords'] as List<dynamic>).cast<String>(),
        passwordIcons = (json['passwordIcons'] as List<dynamic>).cast<String>(),
        notes = (json['notes'] as List<dynamic>).cast<String>(),
        paymentCards = (json['paymentCards'] as List<dynamic>).cast<String>(),
        idCards = (json['idCards'] as List<dynamic>).cast<String>(),
        identities = (json['identities'] as List<dynamic>).cast<String>();

  List<String> getKeys(EntryType type) {
    switch (type) {
      case EntryType.password:
        return passwords;
      case EntryType.passwordIcon:
        return passwordIcons;
      case EntryType.paymentCard:
        return paymentCards;
      case EntryType.note:
        return notes;
      case EntryType.idCard:
        return idCards;
      case EntryType.identity:
        return identities;
      default:
        return [];
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'passwords': passwords,
        'passwordIcons': passwordIcons,
        'notes': notes,
        'paymentCards': paymentCards,
        'idCards': idCards,
        'identities': identities,
      };
}

class _EntryInfo with JsonConvertable {
  final History history;
  final _Request request;

  _EntryInfo({
    History? history,
    _Request? request,
  })  : history = history ?? History(),
        request = request ?? _Request();

  _EntryInfo.fromJson(Map<String, dynamic> json)
      : history = History.fromJson((json['history'] as Map<String, dynamic>)),
        request = _Request.fromJson(json['request']);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'history': history.toJson(),
        'request': request.toJson(),
      };
}

class Synchronization {
  final LoadedAccount _loadedAccount;
  final History _history;
  final Encrypter _encrypter;
  final void Function()? _onComplete;
  final void Function(String log)? _onError;
  static ServerSocket? _server;
  static Socket? _socket;
  String _syncLog = '';
  bool _isConnected = false;

  Synchronization(this._loadedAccount,
      {required History history,
      required Encrypter encrypter,
      void Function()? onComplete,
      void Function(String log)? onError})
      : _history = history,
        _encrypter = encrypter,
        _onComplete = onComplete,
        _onError = onError;

  void _handleException(String message) {
    _socket?.destroy();
    _socket = null;
    if (_server != null) {
      _server?.close();
      _server = null;
    }
    String _exception = '\nLocal exception has occurred: $message';
    _syncLog += _exception;
    _onError?.call(_syncLog);
    _onComplete?.call();
  }

  List<List<int>> _encodeData(_Request request) {
    List<List<int>> _data = [];

    for (EntryType entryType in EntryType.values) {
      for (String key in request.getKeys(entryType)) {
        _data.add(utf8.encode(
            '${encrypt(jsonEncode(_EntryData(key: key, type: entryType, event: _history.getEvents(entryType)[key]!, value: _loadedAccount.getEntry(entryType)(key)?.toCSV())), encrypter: _encrypter)}\u0000'));
      }
    }

    return _data;
  }

  Future<void> _sendEntries(_Request request) async {
    List<List<int>> _data = _encodeData(request);
    for (List<int> element in _data) {
      _socket?.add(element);
      await _socket?.flush();
    }
  }

  Future<void> _decryptEntries(List<List<int>> entries) async {
    for (List<int> entry in entries) {
      _EntryData _entryData;
      try {
        _entryData = _EntryData.fromJson(
            jsonDecode(decrypt(utf8.decode(entry), encrypter: _encrypter)));
      } catch (e, s) {
        _handleException(
            'Could not decode an entry.\n${e.toString()}\n${s.toString()}');
        return;
      }

      try {
        Map<String, EntryEvent> _events = _history.getEvents(_entryData.type);

        if (_entryData.event.status == EntryStatus.removed) {
          if (_events.containsKey(_entryData.key)) {
            if (_events[_entryData.key]!.status == EntryStatus.alive) {
              _loadedAccount.removeEntry(_entryData.type)(_entryData.key);
            }
          }
          _events[_entryData.key] = _entryData.event;
          continue;
        }

        _loadedAccount.setEntry(_entryData.type)(
            Entry.fromCSV(_entryData.type)(_entryData.value!));
        _events[_entryData.key] = _entryData.event;
      } catch (e, s) {
        _handleException(
            'Could not save an entry\n${e.toString()}\n${s.toString()}');
      }
    }
    return _loadedAccount.save();
  }

  Future<List<List<int>>> _handleEntries(
    PmpStreamSubscription subscription, {
    required int entryCount,
    VoidCallback? onFirstReceive,
  }) {
    List<List<int>> _entries = [];
    Completer<List<List<int>>> _completer = Completer<List<List<int>>>();

    void _handleEntries(List<int> data) {
      _entries.add(data);
      entryCount--;
      if (entryCount == 0) _completer.complete(_entries);
    }

    subscription.onDone(() {
      if (!_completer.isCompleted) _completer.complete(_entries);
    });

    if (entryCount == 0) {
      subscription.onData((data) {
        if (onFirstReceive != null) onFirstReceive!();
      });
      _completer.complete(_entries);
      return _completer.future;
    }

    if (onFirstReceive != null) {
      subscription.onData((data) {
        onFirstReceive!();
        onFirstReceive = null;
        subscription.onData(_handleEntries);
        _handleEntries(data);
      });
    } else {
      subscription.onData(_handleEntries);
    }

    return _completer.future;
  }

  Future<HostAddress?> host({void Function()? onConnected}) async {
    _syncLog = 'Hosting... ';
    HostAddress? _address;
    String _ip = '127.0.0.1';
    List<NetworkInterface> _interfaces =
        await NetworkInterface.list(type: InternetAddressType.IPv4);
    for (NetworkInterface element in _interfaces) {
      for (InternetAddress ip in element.addresses) {
        List<String> _ipList = ip.address.split('.');
        if (_ipList[2] == '1') _ip = ip.address;
      }
    }

    try {
      if (_server != null) await _server?.close();
      _syncLog += 'done. \nListening... ';

      await ServerSocket.bind(_ip, 0).then((server) {
        _server = server;
        _address = HostAddress(InternetAddress(_ip), server.port);
        server.listen(
          (socket) {
            if (_socket != null) {
              _socket?.destroy();
              return;
            }
            if (onConnected != null) onConnected();
            _socket = socket;
            _isConnected = true;

            PmpStreamSubscription _sub = PmpStreamSubscription(socket.listen(
              null,
              onError: (e, s) => _handleException(
                  'Connection error.\n${e.toString()}\n${s.toString()}'),
              onDone: () {
                if (_socket != null) {
                  _handleException('Remote disconnected unexpectedly.');
                }
              },
            ));

            Future<void> _sendInfo(_EntryInfo info) {
              _syncLog += 'done.\nSending info... ';
              socket.add(utf8.encode(
                  '${encrypt(jsonEncode(info), encrypter: _encrypter)}\u0000'));
              return socket.flush();
            }

            void _handleHistory(List<int> data) {
              _syncLog += 'done.\nReceiving history... ';
              _EntryInfo _info;
              _Request _remoteRequest;
              History _remoteHistory;

              try {
                String _data = utf8.decode(data);
                if (_data == _sameHistoryHash) {
                  _socket = null;
                  socket.destroy();
                  server.close();
                  _onComplete?.call();
                  return;
                }
                _remoteHistory = History.fromJson(
                    jsonDecode(decrypt(_data, encrypter: _encrypter)));
              } catch (e, s) {
                _handleException(
                    'Could not decode history.\n${e.toString()}\n${s.toString()}');
                return;
              }

              {
                _info = _EntryInfo();
                _remoteRequest = _Request();

                for (EntryType entryType in EntryType.values) {
                  Map<String, EntryEvent> _localEvents =
                      _history.getEvents(entryType);
                  Map<String, EntryEvent> _shortLocalEvents =
                      _info.history.getEvents(entryType);
                  List<String> _localRequestKeys =
                      _info.request.getKeys(entryType);
                  Map<String, EntryEvent> _remoteEvents =
                      _remoteHistory.getEvents(entryType);
                  List<String> _remoteRequestKeys =
                      _remoteRequest.getKeys(entryType);

                  for (String key in _localEvents.keys
                      .followedBy(_remoteEvents.keys)
                      .toSet()) {
                    DateTime _localLastModified;
                    EntryEvent _localEvent;
                    EntryEvent _remoteEvent;

                    if (!_localEvents.containsKey(key)) {
                      _localRequestKeys.add(key);
                      continue;
                    }
                    _localEvent = _localEvents[key]!;
                    if (!_remoteEvents.containsKey(key)) {
                      _shortLocalEvents[key] = _localEvent;
                      _remoteRequestKeys.add(key);
                      continue;
                    }
                    _remoteEvent = _remoteEvents[key]!;

                    _localLastModified = _localEvent.lastModified;

                    if (_localLastModified
                        .isBefore(_remoteEvent.lastModified)) {
                      _localRequestKeys.add(key);
                      continue;
                    }
                    if (_localLastModified.isAfter(_remoteEvent.lastModified)) {
                      _shortLocalEvents[key] = _localEvent;
                      _remoteRequestKeys.add(key);
                    }
                  }
                }
              }

              {
                Completer<void> _sendEntriesCompleter = Completer();
                Future<List<List<int>>> _handleEntriesFuture =
                    _handleEntries(_sub, entryCount: _info.request.length,
                        onFirstReceive: () {
                  _sendEntries(_remoteRequest)
                      .then((value) => _sendEntriesCompleter.complete());
                });
                Completer<void> _decryptEntriesCompleter = Completer();

                if (_info.request.length != 0) {
                  _handleEntriesFuture.then((value) {
                    _decryptEntries(value)
                        .then((value) => _decryptEntriesCompleter.complete());
                  });
                } else {
                  _decryptEntriesCompleter.complete();
                }

                _handleEntriesFuture.then((value) async {
                  await _sendEntriesCompleter.future;
                  // Disconnect
                  _socket?.destroy();
                  _socket = null;
                  server.close();
                  _server = null;
                  await _decryptEntriesCompleter.future;
                  // Cleanup
                  _syncLog += 'done.';
                  _isConnected = false;
                  _onComplete?.call();
                });
                _sendInfo(_info);
                _syncLog += 'done.\nExchanging data... ';
              }
            }

            Future<void> _sendHistoryHash() {
              _syncLog += 'done.\nSending history hash... ';
              Map<String, dynamic> _localHistory = _history.toJson();
              socket.add(
                  utf8.encode('${getHash(jsonEncode(_localHistory))}\u0000'));
              return socket.flush();
            }

            void _handleHello(List<int> data) {
              _syncLog += 'done.\nReceiving hello... ';
              String _data;
              try {
                _data = utf8.decode(data);
              } catch (e, s) {
                _handleException(
                    'Could not decode hello.\n${e.toString()}\n${s.toString()}');
                return;
              }
              try {
                _data = decrypt(decrypt(_data, encrypter: _encrypter),
                    encrypter: getEncrypter(_loadedAccount.username));
              } catch (e, s) {
                _handleException(
                    'Could not decrypt hello. Make sure that local and remote username and password are the same.\n${e.toString()}\n${s.toString()}');
                return;
              }
              if (_data != _hello) {
                _handleException(
                    'Hello is incorrect. Expected \'$_hello\', received \'$_data\'.');
                return;
              }
              _sub.onData((data) => _handleHistory(data));
              _sendHistoryHash();
            }

            Future<void> _sendServiceInfo() {
              _syncLog += 'done.\nSending service info... ';
              socket.add(utf8.encode('Passy $syncVersion\u0000'));
              return socket.flush();
            }

            _sub.onData(_handleHello);
            _sendServiceInfo();
          },
        );
      });
      return _address;
    } catch (e, s) {
      _handleException('Failed to host.\n${e.toString()}\n${s.toString()}');
    }
    return null;
  }

  Future<void> connect(HostAddress address) {
    void _onConnected(Socket socket) {
      _isConnected = true;
      bool _serviceInfoHandled = false;
      _socket = socket;
      PmpStreamSubscription _sub = PmpStreamSubscription(socket.listen(
        null,
        onError: (e, s) => _handleException(
            'Connection error.\n${e.toString()}\n${s.toString()}'),
        onDone: () {
          if (_socket != null) {
            _handleException('Remote disconnected unexpectedly.');
          }
        },
      ));

      Future<void> _handleInfo(List<int> data) async {
        _syncLog += 'done.\nReceiving info... ';
        _EntryInfo _info;

        try {
          _info = _EntryInfo.fromJson(
              jsonDecode(decrypt(utf8.decode(data), encrypter: _encrypter)));
        } catch (e, s) {
          _handleException(
              'Could not decode info.\n${e.toString()}\n${s.toString()}');
          return;
        }

        {
          int _requestLength = _info.history.length;
          Future<List<List<int>>> _handleEntriesFuture = _handleEntries(
            _sub,
            entryCount: _requestLength,
          );
          Completer<void> _decryptEntriesCompleter = Completer();
          Completer<void> _sendEntriesCompleter = Completer();

          if (_requestLength != 0) {
            _handleEntriesFuture.then((value) {
              _decryptEntries(value)
                  .then((value) => _decryptEntriesCompleter.complete());
            });
          } else {
            _decryptEntriesCompleter.complete();
          }

          _syncLog += 'done.\nExchanging data... ';
          if (_info.request.length == 0) {
            socket.add(utf8.encode('ready\u0000'));
            await socket.flush();
            _sendEntriesCompleter.complete();
          } else {
            _sendEntries(_info.request)
                .then((value) => _sendEntriesCompleter.complete());
          }

          _handleEntriesFuture.then((value) async {
            await _sendEntriesCompleter.future;
            _socket?.destroy();
            _socket = null;
            await _decryptEntriesCompleter.future;
            _syncLog += 'done.';
            _onComplete?.call();
          });
        }
      }

      Future<void> _sendHistory(String historyCSV) {
        _syncLog += 'done.\nSending history... ';
        socket.add(
            utf8.encode('${encrypt(historyCSV, encrypter: _encrypter)}\u0000'));
        return socket.flush();
      }

      void _handleHistoryHash(List<int> data) {
        _syncLog += 'done.\nReceiving history hash... ';
        String _historyJson = jsonEncode(_history.toJson());
        bool _same = true;
        try {
          _same = getHash(_historyJson) == Digest(data);
        } catch (e, s) {
          _handleException('Could not read history hash.\n${s.toString()}');
          return;
        }
        if (_same) {
          _socket = null;
          Future.delayed(const Duration(seconds: 16), () => socket.destroy());
          socket.add(utf8.encode('$_sameHistoryHash\u0000'));
          socket.flush();
          return;
        }
        _sub.onData(_handleInfo);
        _sendHistory(_historyJson);
      }

      Future<void> _sendHello(String hello) {
        _syncLog += 'done.\nSending hello... ';
        socket.add(utf8.encode('$hello\u0000'));
        return socket.flush();
      }

      void _handleServiceInfo(List<int> data) {
        if (_serviceInfoHandled) return;
        _serviceInfoHandled = true;
        _syncLog += 'done.\nReceiving service info... ';
        List<String> _info = [];
        try {
          _info = utf8.decode(data).split(' ');
        } catch (e, s) {
          _handleException(
              'Could not decode hello.\n${e.toString()}\n${s.toString()}');
          return;
        }
        if (_info.length < 2) {
          _handleException(
              'Service info is less than 2 parts long. Info length: ${_info.length}.');
          return;
        }
        if (_info[0] != 'Passy') {
          _handleException(
              'Remote service is not Passy. Service name: ${_hello[0]}.');
          return;
        }
        if (syncVersion != _info[1]) {
          _handleException(
              'Local and remote versions are different. Local version: $syncVersion. Remote version: ${_info[1]}.');
          return;
        }
        _sub.onData(_handleHistoryHash);
        _sendHello(encrypt(
            encrypt(_hello, encrypter: getEncrypter(_loadedAccount.username)),
            encrypter: _encrypter));
      }

      _sub.onData(_handleServiceInfo);
    }

    _syncLog = 'Connecting... ';
    return Socket.connect(address.ip, address.port,
            timeout: const Duration(seconds: 8))
        .then((socket) => _onConnected(socket),
            onError: (e, s) => _handleException(
                'Failed to connect.\n${e.toString()}\n${s.toString()}'));
    // Ask server for data hashes, if they are not the same, exchange data
  }

  void close() {
    if (!_isConnected) {
      _server?.close();
      _socket?.destroy();
      _onComplete?.call();
    } else {
      _handleException('Synchronization requested to close while connected.');
    }
  }
}
