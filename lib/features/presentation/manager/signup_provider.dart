import 'dart:io';

import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  bool passwordNotVisible = true;
  bool confirmPasswordNotVisible = true;
  File? profilePhotoFile;
  int fileUploadPercentage = 0;


  updateFileUploadPercentage(int value) {
    fileUploadPercentage = value;
    notifyListeners();
  }

  updateProfilePhoto(File file){
    profilePhotoFile = file;
    notifyListeners();
  }

  unsetProfilePhoto() {
    profilePhotoFile = null;
    notifyListeners();
  }

  passwordVisibleToggle() {
    passwordNotVisible = !passwordNotVisible;
    notifyListeners();
  }

  confirmPasswordVisibleToggle() {
    confirmPasswordNotVisible = !confirmPasswordNotVisible;
    notifyListeners();
  }
  
}