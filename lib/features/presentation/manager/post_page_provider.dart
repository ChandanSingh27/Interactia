import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'package:uuid/uuid.dart';
import 'package:easy_isolate/easy_isolate.dart';

import '../../../common/local_storage.dart';

class PostPageProvider with ChangeNotifier {
  String? postImage;

  List<String> images = [];

  setPostImage(String postImages) {
    postImage = postImages;
    notifyListeners();
  }

  unsetPostImage() {
    postImage = null;
    deleteFolder("Photos");
    notifyListeners();
  }

  uploadPost() {

    unsetPostImage();
  }

  // getPhotosList() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   List<String>? photoLists = await LocalStorage.getKeyListValue(key: SharePreferenceConstantText.cameraPhotos);
  //   int numberOfPhotos = await getCameraPhotoNumbers();
  //   if(photoLists != null && photoLists.isNotEmpty && photoLists.length == numberOfPhotos) {
  //     images = photoLists;
  //     notifyListeners();
  //   }else{
  //     List<String> cameraPhotos = await getImageFromInternalStorageCamera();
  //     preferences.remove(SharePreferenceConstantText.cameraPhotos);
  //     LocalStorage.setPhotoLists(cameraPhotoLists: cameraPhotos);
  //     images = cameraPhotos;
  //     notifyListeners();
  //   }
  // }

  // Future<int> getCameraPhotoNumbers() async{
  //   String path = await ExternalPath.getExternalStoragePublicDirectory(
  //       ExternalPath.DIRECTORY_DCIM);
  //   Directory dic = Directory("$path/Camera");
  //   List<FileSystemEntity> files = dic.listSync();
  //   int photos = -1;
  //   for (var element in files) {
  //     if (element.path.endsWith(".jpg") || element.path.endsWith(".jpeg")) {
  //       photos++;
  //     }
  //   }
  //   return photos;
  // }

  getImageFromInternalStorageCamera() async {
    String path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DCIM);
    Directory photoDirectory = await createFolder("Photos");
    getImages(path, photoDirectory.path);
  }

  getImages(String cameraPath,String compressPhotoPath) async{
    Directory dic = Directory("$cameraPath/Camera");
    List<FileSystemEntity> files = dic.listSync();
    for (var element in files) {
      if (element.path.endsWith(".jpg") || element.path.endsWith(".jpeg")) {
        XFile? file = await FlutterImageCompress.compressAndGetFile(element.path,"$compressPhotoPath/img${Random.secure().nextInt(221324)}.jpg", quality: 30);
        if (file != null) {
          images.add(file.path.toString());
          if(images.length==1) postImage = images[0];
          notifyListeners();
        }
      }
    }
  }

  Future<Directory> createFolder(String folderName) async {
    Directory? applicationPath = await getExternalStorageDirectory();
    String folderPath = "${applicationPath!.path}/$folderName";
    Directory photoFolderPath = Directory(folderPath);
    if(await photoFolderPath.exists()) {
        return photoFolderPath;
    }else{
      photoFolderPath.create(recursive: true);
      return photoFolderPath;
    }
  }

  deleteFolder(String folderName) async{
    Directory? applicationPath = await getExternalStorageDirectory();
    String deleteFolderPath = "${applicationPath!.path}/$folderName";
    Directory deleteFolder = Directory(deleteFolderPath);
    if(await deleteFolder.exists()) deleteFolder.delete(recursive: true);
  }

}
