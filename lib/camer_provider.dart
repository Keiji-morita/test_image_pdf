  
  // 利用可能なカメラのリストから特定のカメラを取得
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraProvider = FutureProvider((ref) async { 
    final cameras = await availableCameras();
    return cameras.first;
  });