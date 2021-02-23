import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:share/share.dart';

class ShowPDF extends StatelessWidget {
  final String path;

  ShowPDF({this.path});

  Future<void> shareFile() async {
    List<String> paths = [this.path];

    Share.shareFiles(
      paths,
      subject: 'Share ScreenShot',
      text: 'Hello, check your share files!',
      // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
    );
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("PDF"),
            FlatButton(
              onPressed: () {
                shareFile();
              },
              child: Icon(
                Icons.share,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      path: this.path,
    );
  }
}
