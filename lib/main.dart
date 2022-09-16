import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'main_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  // デバイスで使用可能なカメラのリストを取得

  
  runApp(
    ProviderScope(child:
    MaterialApp(
      home: MainPage()
    )
  ));
}


