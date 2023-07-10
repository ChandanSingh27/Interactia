import 'dart:io';

import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  bool passwordNotVisible = true;
  bool confirmPasswordNotVisible = true;
  File? profilePhotoFile;

  updateProfilePhoto(File file){
    profilePhotoFile = file;
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