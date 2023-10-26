import 'dart:convert';
import 'dart:typed_data';
import 'package:pdft/data.dart';
import 'package:pdfx/pdfx.dart';

Future<String?> pdfPageToBase64(Uint8List pdfBytes) async {
  final document = await PdfDocument.openData(pdfBytes);
  final page = await document.getPage(1);

  // Convert PDF to JPG
  final image = await page.render(
    width: page.width,
    height: page.height,
    format: PdfPageImageFormat.jpeg,
  );

  // Convert image bytes to base64
  final base64Image = base64Encode(image!.bytes);

  // Close the page and document to free resources
  page.close();
  document.close();
  data['pdf'] = base64Image;
  data['body'] = {
    'base64': base64Image,
  };
  print(data['body']);
  return base64Image;
}
