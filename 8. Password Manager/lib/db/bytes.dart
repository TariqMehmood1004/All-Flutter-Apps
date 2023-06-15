import 'dart:convert';
import 'dart:typed_data';

import 'package:app/db/entry.dart';

class Bytes extends Entry<Bytes> {
  Uint8List value;

  Bytes(String key, {required this.value}) : super(key);

  Bytes.fromJson(Map<String, dynamic> json)
      : value = base64Decode(json['value']),
        super(json['key']);

  Bytes.fromCSV(List csv)
      : value = base64Decode(csv[1]),
        super(csv[0]);

  @override
  int compareTo(Bytes other) => key.compareTo(other.key);

  @override
  Map<String, dynamic> toJson() => {
        'key': key,
        'value': base64Encode(value),
      };

  @override
  List<List> toCSV() => [
        [
          key,
          base64Encode(value),
        ]
      ];
}
