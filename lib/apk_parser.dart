import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class ApkInfo {
  String label;
  String name;
  String packageName;
  String versionName;
  int versionCode;
  List icons;
  ApkInfo({this.label, this.name, this.versionCode, this.versionName, this.packageName, this.icons});
  Uint8List get largestIcon {
    if (icons == null || icons.length == 0) {
      return null;
    }
    Uint8List temp = icons[0];
    for (Uint8List icon in icons) {
      if (icon.length > temp.length) {
        temp = icon;
      }
    }
    return temp;
  }

  @override
  String toString() {
    return 'ApkInfo{label: $label, name: $name, packageName: $packageName, versionName: $versionName, versionCode: $versionCode, icons: $icons}';
  }
}

class ApkParser {
  static const MethodChannel _channel = const MethodChannel('apk_parser');

  static Future<ApkInfo> parse(String path) async {
    final Map info = await _channel.invokeMethod('apkParse', {"path": path});
    print(info);
    return ApkInfo(label: info['label'], name: info['name'], packageName: info['packageName'], versionCode: info['versionCode'], versionName: info['versionName'], icons: info['iconDatas']);
  }
}
