import 'package:flutter/material.dart';
import 'database_models/database_model.dart';
import 'imagecard.dart';

class ImageList extends StatelessWidget {
  // create an object of database connect
  var database = DatabaseConnect();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: database.getFilePathName(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          var data = snapshot.data; // shows list of filepath
           var datalength = data!.length;
          return datalength == 0 ?
          Center(child: Text('No image downloaded yet'),
          ) :
          ListView.builder(
            itemCount: datalength,
            itemBuilder: (context, i) => ImageCard(
              id: data[i].id,
              filepath:data[i].filepath,
            ),
          );
        },
      ),
    );
  }
}
