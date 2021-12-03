class Filepath {
  int? id ;
  final String filepath ;


  // create constructor
 Filepath (
      {
        this.id,
        required this.filepath
      });

  // saving data in database in a map format
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'file' : filepath.toString(),
    };
  }
  @override
  String toString() {
    return 'Filepath(id : $id, filepath : $filepath)';
  }
}
