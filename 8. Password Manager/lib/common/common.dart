import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../db/common.dart';
import '../db/pdata.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
late Data data;

Future<Data> loadData() async {
  return Data(
      '${(await getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}');
}

Future<String> getLatestVersion() async {
  try {
    String version = (jsonDecode(await http.read(
      Uri.https('api.github.com', 'repositories/469494355/releases/latest'),
    ))['tag_name'] as String);
    if (version[0] == 'v') {
      version = version.substring(1);
    }
    return version;
  } catch (_) {
    return Version;
  }
}
