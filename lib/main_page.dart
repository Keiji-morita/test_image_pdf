import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfmaker2/camer_provider.dart';
import 'package:pdfmaker2/camera_page.dart';
import 'package:printing/printing.dart';
// import 'package:riverpod/riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  File? file;
  ImagePicker image = ImagePicker();
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);

    setState(() {
      file = File(img!.path);
    });
  }

  getImagecam() async {
    var img = await image.pickImage(source: ImageSource.camera);

    setState(() {
      file = File(img!.path);
    });
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, file) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    final showimage = pw.MemoryImage(file.readAsBytesSync());

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Center(
            child: pw.Image(showimage, fit: pw.BoxFit.contain),
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    final cameraP = ref.watch(cameraProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(" WEB FUN pdf maker"),
        actions: [
          IconButton(
            onPressed: getImage,
            icon: Icon(Icons.image),
          ),
          cameraP.when(
              data: (data) => IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TakePictureScreen(camera: data)));
                    },
                    icon: Icon(Icons.camera),
                  ),
              error: (e, stc) => const SizedBox(),
              loading: () => const SizedBox())
        ],
      ),
      body: file == null
          ? Container()
          : PdfPreview(
              build: (format) => _generatePdf(format, file),
            ),
    );
  }
}
