import 'package:flutter/cupertino.dart';

class LoginPageProvider with ChangeNotifier {
  bool passwordVisible = true;
  bool loginButtonDisable = true;
  bool loadingLoader = false;


  passwordVisibleToggle(){
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  isLoadingButtonEnable(bool value){
    loginButtonDisable = value;
    notifyListeners();
  }

  loadingLoaderToggle(){
    loadingLoader = !loadingLoader;
    notifyListeners();
  }


}