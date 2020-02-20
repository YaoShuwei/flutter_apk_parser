import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:apk_parser/apk_parser.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List icon;
  ApkInfo apkInfo;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Text("选择apk"),
                onPressed: () async {
                  try {
                    File file = await FilePicker.getFile();
                    if (file != null) {
                      print(file.path);
                      apkInfo = await ApkParser.parse(file.path);
                      setState(() {});
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              if (apkInfo != null) ...[
                if (apkInfo.largestIcon != null)
                  Image.memory(
                    apkInfo.largestIcon,
                    width: 200,
                  ),
                Text("package name:${apkInfo.packageName}"),
                Text("label name:${apkInfo.label}"),
                Text("app name:${apkInfo.name}"),
                Text("version name:${apkInfo.versionName}"),
                Text("version code:${apkInfo.versionCode}"),
                Text("package name:${apkInfo.packageName}"),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
