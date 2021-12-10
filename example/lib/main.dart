import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quick_breakpad/quick_breakpad.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final path = p.join(p.dirname(Platform.resolvedExecutable), 'crash');
    QuickBreakpad.setDumpPath(path);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $defaultTargetPlatform\n'),
        ),
      ),
    );
  }
}
