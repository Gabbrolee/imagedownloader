import 'package:file_downloader/database_models/models.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ImageCard extends StatefulWidget {
  final int id;
  final String filepath;


  ImageCard(
      {required this.id,
        required this.filepath,
        Key? key})
      : super(key: key);

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {

  var color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Row(
            children: [
              Container(
                child: Image.file(
                    File(widget.filepath),
                  height: 50,
                )
              ),
            ],
          ),
        ),
      );
  }
}