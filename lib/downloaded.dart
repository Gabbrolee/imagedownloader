import 'package:file_downloader/imagelist.dart';
import 'package:flutter/material.dart';
class DownloadedImages extends StatefulWidget {
  const DownloadedImages({Key? key}) : super(key: key);

  @override
  _DownloadedImagesState createState() => _DownloadedImagesState();
}

class _DownloadedImagesState extends State<DownloadedImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List of downloaded images'
        ),
      ),
      body: Column(
        children: [
          ImageList(),
        ],
      ),
    );
  }
}
