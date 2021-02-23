import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_generator_flutter/Data.dart';
import 'package:pdf_generator_flutter/ShowPDF.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pdf = pw.Document();

    List<Data> data = [
      new Data("Joniyed", 1),
      new Data("Roni", 2),
      new Data("Nafiul", 3),
      new Data("John", 4),
      new Data("Deo", 5),
      new Data("Rajon", 6),
      new Data("Kamrul", 7),
    ];
    // writeOnPdf() {
    //   pdf.addPage(pw.MultiPage(
    //     pageFormat: PdfPageFormat.a4,
    //     margin: pw.EdgeInsets.all(32),
    //     build: (pw.Context context) {
    //       return <pw.Widget>[
    //         pw.Header(level: 0, child: pw.Text("Easy Approach Document")),
    //         pw.Paragraph(
    //             text:
    //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
    //         pw.Paragraph(
    //             text:
    //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
    //         pw.Header(level: 1, child: pw.Text("Second Heading")),
    //         pw.Paragraph(
    //             text:
    //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
    //         pw.Paragraph(
    //             text:
    //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
    //         pw.Paragraph(
    //             text:
    //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
    //       ];
    //     },
    //   ));
    // }

    writeOnPdf() {
      pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(level: 0, child: pw.Text("Table")),
            pw.Table.fromTextArray(
              data: <List<String>>[
                <String>[
                  'Name',
                  'Number',
                ],
                for (int i = 0; i < data.length; i++)
                  <String>[
                    data[i].name,
                    data[i].number.toString(),
                  ],
              ],
            ),
          ];
        },
      ));
    }

    Future savePdf() async {
      Directory documentDirectory = await getTemporaryDirectory();

      String documentPath = documentDirectory.path;

      File file = File("$documentPath/example.pdf");

      print(file.path);

      file.writeAsBytesSync(await pdf.save());

      // Delete after done
      // file.delete();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Container(
          child: Text("PDF Demo"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            writeOnPdf();
            await savePdf();

            Directory documentDirectory =
                await getApplicationDocumentsDirectory();

            String documentPath = documentDirectory.path;

            String fullPath = "$documentPath/example.pdf";

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowPDF(
                          path: fullPath,
                        )));
          },
          child: Icon(Icons.save)),
    );
  }
}
