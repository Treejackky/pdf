import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdft/data.dart';
import 'package:pdft/img.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _createPDF();
            },
            child: Text('Hello World!'),
          ),
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    ByteData fontData = await rootBundle.load('src/font/ANGSA.ttf');
    List<int> fontBytes = fontData.buffer.asUint8List();
    double size = 9;
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString(
        '                   สัญญานี้ทําเมื่อวันที่ ระหว่าง บริษัท ศุภธนรังสี เรียลเอส เตท จํากัด \n ซึ่งต่อไปในสัญญานี้จะเรียกว่า “ผู้ให้กู้” ฝ่ายหนึ่ง กับ  ผู้กู้ตามมาตรการทวงถามด้านล่าง',
        PdfTrueTypeFont(fontBytes, size));
    Uint8List bytes = Uint8List.fromList(await document.save());
    await pdfPageToBase64(bytes);
    document.dispose();
    api();
  }
}

Future<void> api() async {
  final url = Uri.parse('http://192.168.56.1:3000/upload');
  final body = (jsonEncode(data['body']));
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );

  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.body);
  }
}
