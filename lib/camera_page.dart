// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class MyApp extends StatelessWidget {
//   const MyApp({
//     Key? key,
//     required this.camera,
//   }) : super(key: key);

//   final CameraDescription camera;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Camera Example',
//       theme: ThemeData(),
//       home: TakePictureScreen(camera: camera),
//     );
//   }
// }

// /// 写真撮影画面
// class TakePictureScreen extends StatefulWidget {
//   const TakePictureScreen({
//     Key? key,
//     required this.camera,
//   }) : super(key: key);

//   final CameraDescription camera;

//   @override
//   TakePictureScreenState createState() => TakePictureScreenState();
// }

// class TakePictureScreenState extends State<TakePictureScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   final _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();

//     _controller = CameraController(
//       // カメラを指定
//       widget.camera,
//       // 解像度を定義
//       ResolutionPreset.medium,
//     );

//     // コントローラーを初期化
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // ウィジェットが破棄されたら、コントローラーを破棄
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder<void>(
//           future: _initializeControllerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return CameraPreview(_controller);
//             } else {
//               return const CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // 写真を撮る
//           final image = await _controller.takePicture();
//           // 表示用の画面に遷移
//           await Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => DisplayPictureScreen(imagePath: image.path),
//               fullscreenDialog: true,
//             ),
//           );
//         },
//         child: const Icon(Icons.camera_alt),
//       ),
//     );
//   }
// }

// // 撮影した写真を表示する画面
// class DisplayPictureScreen extends StatelessWidget {
//   const DisplayPictureScreen({Key? key, required this.imagePath})
//       : super(key: key);

//   final String imagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('撮れた写真')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//         Image.file(File(imagePath)),
//         ElevatedButton(
//           onPressed: () {

//           },
//           child: Text("写真をpdf化"),
          
//         )
//           ]
//         )
//       ),
//     );
//   }

//   Future<void> convertImage() async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Center(child: pw.Image(

//           ));
//         }
//       )
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key}) : super(key: key);

  // final String title;
    

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  // imagepickerを使うために次の二行を追加する
  File? _image;
  final _picker = ImagePicker();


  Future getImageFromCamera() async {
    // カメラから写真を取得する部分
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        // 写真取得後に_imageを更新して表示している
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('カメラ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        // imageがnullだったら写真を撮る
        child: _image == null?
            Text('写真を撮る')
            : Image.file(_image!),
      ),
      // floatingActionButtonLocationでボタンの位置を指定します
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: getImageFromCamera,
        child: Icon(Icons.photo_camera,
          // カメラアイコンの色を指定
          color: Colors.white,
        ),
        // アイコンの背景の色を指定
        backgroundColor: Colors.cyan,
      ),
    );
  }
}