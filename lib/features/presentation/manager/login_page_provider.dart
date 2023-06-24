import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class LoginPageProvider with ChangeNotifier {
  bool passwordVisible = true;
  bool loginButtonDisable = true;
  bool loginButtonLoader = false;
  bool continueWithPhoneButtonLoader = false;
  bool continueWithGoogleButtonLoader = false;
  bool sendMeCodeLoader = false;

  bool disableSendMeCodeButton = true;
  bool enableContinueWithPhoneButton = true;
  bool enableContinueWithGoogleButton = true;

  String countryCode = "+91";

  setCountryCode(String code){
    countryCode = code;
    notifyListeners();
  }

  toggleEnableSendMeCodeButton(bool value) {
    disableSendMeCodeButton = value;
    notifyListeners();
  }
  toggleEnableSendMeCodeButtonLoader() {
    sendMeCodeLoader = !sendMeCodeLoader;
    notifyListeners();
  }
  toggleEnableContinueWithGoogleButtonAndLoader() {
    enableContinueWithGoogleButton = !enableContinueWithGoogleButton;
    continueWithGoogleButtonLoader = !continueWithGoogleButtonLoader;
    notifyListeners();
  }

  toggleEnableContinueWithPhoneButtonAndLoader() {
    enableContinueWithPhoneButton = !enableContinueWithPhoneButton;
    continueWithPhoneButtonLoader = !continueWithPhoneButtonLoader;
    notifyListeners();
  }

  passwordVisibleToggle(){
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  isLoadingButtonEnable(bool value){
    loginButtonDisable = value;
    notifyListeners();
  }

  loadingLoaderToggle(){
    loginButtonLoader = !loginButtonLoader;
    notifyListeners();
  }


}