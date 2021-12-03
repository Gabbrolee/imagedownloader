import 'package:file_downloader/database_models/models.dart';
import 'package:file_downloader/downloaded.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_downloader/database_models/database_model.dart';


class DownloadFile extends StatefulWidget {
  @override
  State createState() {
    return _DownloadFileState();
  }
}

var imagelink = TextEditingController();

class _DownloadFileState extends State {
  var imageUrl =  '';
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";

  @override
  void initState() {
    super.initState();
   // downloadFile();
  }

  Future downloadFile(String imageUrl) async {
    try {
      Dio dio = Dio();

      String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      savePath = await getFilePath(fileName);
      await dio.download(imageUrl, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          // download = (rec / total) * 100;
          downloadingStr =
          "Downloading Image : $rec" ;
          print(downloadingStr);
          print('fsgsgs - $savePath');
        });


      } );
      setState(() {
        downloading = false;
        downloadingStr = "Completed";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }
  var database = DatabaseConnect();
  void addItem(Filepath filepath) async {
    await database.insertFilePath(filepath);
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Download File"),
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: imagelink,
                decoration: InputDecoration(
                    hintText: 'paste image url here',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black38,
                    )
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    MaterialButton(
                      color: Colors.black,
                      height: 50.0,
                      minWidth: 100.0,
                      child: Text(
                        'View Downloads',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                           DownloadedImages();
                        });
                        await  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DownloadedImages()),
                        );

                      },
                    ),
                    SizedBox(width:  10.0,),
                    MaterialButton(
                      color: Colors.black,
                      height: 50.0,
                      minWidth: 100.0,
                      child: Text(
                        'Save Image',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      onPressed: () async {
                        var filepath = Filepath(filepath: savePath);
                        await  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DownloadedImages()),
                        );
                        addItem(filepath);
                      },
                    ),
                    SizedBox(width: 10,),
                    MaterialButton(
                      color: Colors.black,
                      height: 50.0,
                      minWidth: 100.0,
                      child: Text(
                        'Download',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          downloadFile(imagelink.text);
                          print(database.getFilePathName());
                        });

                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: downloading
                    ? Container(
                  height: 250,
                  width: 250,
                  child: Card(
                    color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          downloadingStr,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
                    : Container(
                  height: 250,
                  width: 250,
                  child: Center(
                    child: Image.file(
                      File(savePath),
                      height: 200,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}