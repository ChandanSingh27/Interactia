import 'package:flutter/cupertino.dart';

class LoginPageProvider with ChangeNotifier {
  bool passwordVisible = true;
  bool loginButtonDisable = true;


  passwordVisibleToggle(){
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  loginButtonDisableToggle(bool value){
    loginButtonDisable = value;
    notifyListeners();
  }


}