import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:local_image_provider/local_image_provider.dart' as lip;
import 'package:path_provider/path_provider.dart';

class PostPageProvider with ChangeNotifier {
  File? postImage;

  List<File> images = [];

  setPostImage(File postImages) {
    postImage = postImages;
    notifyListeners();
  }

  unsetPostImage() {
    postImage = null;
    notifyListeners();
  }

  uploadPost() {
    unsetPostImage();
  }

  getImageFromInternalStorageCamera() async {
    String path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DCIM);
    Directory? folderPath = await getExternalStorageDirectory();
    Directory dic = Directory("$path/Camera");
    List<FileSystemEntity> files = dic.listSync();
    for (var element in files) {
      if (element.path.endsWith(".jpg") || element.path.endsWith(".jpeg")) {
        XFile? file = await FlutterImageCompress.compressAndGetFile(element.path,"$folderPath/img${Random.secure().nextInt(221324)}.jpg", quality: 50);
        if (file != null) {
          images.add(File(file.path.toString()));
          notifyListeners();
          if (images.length == 1) postImage = images[0];
        }
      }
    }
    notifyListeners();
  }
}
