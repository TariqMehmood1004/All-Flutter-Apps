
// ignore_for_file: override_on_non_overriding_member

import 'dart:async';

import 'package:flutter/foundation.dart';

class PmpStreamSubscription {
  final StreamSubscription<Uint8List> _subscription;
  List<int> db = [];
  void Function(List<int>)? _handleData;

  PmpStreamSubscription(this._subscription) {
    _subscription.onData((data) {
      for (int n in data) {
        db.add(n);
        if (n == 0) {
          db.removeLast();
          if (_handleData != null) {
            _handleData!(db);
          }
          db = [];
        }
      }
    });
  }

  @override
  Future<E> asFuture<E>([E? futureValue]) =>
      _subscription.asFuture(futureValue);

  @override
  Future<void> cancel() => _subscription.cancel();

  @override
  bool get isPaused => _subscription.isPaused;

  @override
  void onData(void Function(List<int> data)? handleData) =>
      _handleData = handleData;

  @override
  void onDone(void Function()? handleDone) => _subscription.onDone(handleDone);

  @override
  void onError(Function? handleError) => _subscription.onError(handleError);

  @override
  void pause([Future<void>? resumeSignal]) => _subscription.pause(resumeSignal);

  @override
  void resume() => _subscription.resume();
}
