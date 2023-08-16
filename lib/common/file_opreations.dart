import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class FileOperations {

  static Future<String> createFolder ({required String folderName}) async{
    Directory? applicationPath = await getExternalStorageDirectory();
    Directory? createNameFolder = Directory("${applicationPath!.path}/$folderName");
    if(!(await createNameFolder.exists())) createNameFolder.create(recursive: true);
    return createNameFolder.path;
  }

  static deleteFolder ({required String folderName}) async{
    Directory? applicationPath = await getExternalStorageDirectory();
    Directory? deleteNameFolder = Directory("${applicationPath!.path}/$folderName");
    if((await deleteNameFolder.exists())) deleteNameFolder.delete(recursive: true);
  }

  static writeJsonDataIntoFile ({required String filePath,required fileName,required dynamic data}){
    File file = File("$filePath/$fileName");
    file.writeAsString(jsonEncode(data));
  }

  static readJsonDataIntoFile ({required String filePath,required fileName}){
    File file = File("$filePath/$fileName");
    var data = file.readAsStringSync();
    return jsonDecode(data);
  }

}