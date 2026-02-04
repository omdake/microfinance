import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPreviewPage extends StatelessWidget {
  final Uint8List pdfBytes;
  final String fileName;

  const PdfPreviewPage({
    super.key,
    required this.pdfBytes,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(
       title: "Report Preview",
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadPdf(context),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _sharePdf(context),
          ),
        ],
      ),
      body: SfPdfViewer.memory(pdfBytes),
    );
  }

    Future<void> _downloadPdf(BuildContext context) async {
    try {
      final directory = Directory("/storage/emulated/0/Download");
      final file = File("${directory.path}/$fileName");

      await file.writeAsBytes(pdfBytes, flush: true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloaded to Downloads folder")),
      );
    } catch (e) {
      print("Download error: $e");
    }
  }

    Future<void> _sharePdf(BuildContext context) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File("${tempDir.path}/$fileName");

      await file.writeAsBytes(pdfBytes, flush: true);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: "Loan Report",
      );
    } catch (e) {
      print("Share error: $e");
    }
  }

}