import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

Future<String> pickDocument() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    allowCompression: true,
  );

  if (result != null) {
    final String? filePath = result.files.single.path;
    if (filePath != null) {
      final File file = File(filePath);

      // Load the PDF document from the selected file
      final PdfDocument document =
          PdfDocument(inputBytes: file.readAsBytesSync());

      // Extract text from the entire document
      String extractedText = PdfTextExtractor(document).extractText();

      // Return the extracted text
      return extractedText;
    }
  }

  // Return an empty string if no file is selected or there's an error
  return '';
}
