import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskhub/features/domain/use_cases/user_register_use_case.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/otp_verification_page.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/sign_up_page.dart';
import 'package:taskhub/features/presentation/pages/home_page.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_text.dart';

import '../../common/local_storage.dart';
import '../../features/presentation/pages/authentication_pages/sign_up_page_for_google_phone.dart';
import '../../features/presentation/widgets/custom_dialog/app_dialogs.dart';

class FirebaseAuthentication {
  static FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> loginWithEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      firebaseErrorHandler(error.code.toString());
      if(kDebugMode) print("login with email and password  error : ${error.toString()}");
      return false;
    }
  }

  Future<void> loginWithPhoneNumber(BuildContext context, String phoneNumber) async {
    await auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (phoneAuthCredential) async {
              await auth.signInWithCredential(phoneAuthCredential);
            },
            verificationFailed: (error) {
              firebaseErrorHandler(error.code.toString());
            },
            codeSent: (verificationId, forceResendingToken) {
              Get.to(()=>OtpVerificationPage(mobileNumber: phoneNumber, verificationId: verificationId));
            },
            codeAutoRetrievalTimeout: (verificationId) {});
  }

  Future<bool> verifyOTP(
      BuildContext context, String verificationId, String otpCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpCode);
      await auth.signInWithCredential(credential).then((value) {
        checkUserAlreadyRegister(value.user!.uid, "");
      });
      return true;
    } on FirebaseAuthException catch (error) {
      firebaseErrorHandler(error.code.toString());
      if(kDebugMode) print("verify otp error  : ${error.toString()}");
      return false;
    }
  }

  Future<void> googleSigning(BuildContext context) async {
    try{
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth =
      await googleSignInAccount?.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await auth.signInWithCredential(authCredential).then((value) {
          checkUserAlreadyRegister(value.user!.uid,value.user!.email.toString());
      });
    }on FirebaseAuthException catch(error) {
      firebaseErrorHandler(error.code.toString());
      if(kDebugMode) print("google signing error : ${error.toString()}");
    }

  }
  Future<void> checkUserAlreadyRegister(String uid,String email) async {
    try {
      AppDialog.processingDialog(AppConstantsText.checkingAlreadyRegisterInDatabase);
      bool? userAlreadyRegister = await getIt.get<UserRegisterUseCase>().userAlreadyRegisterOrNotUseCase(uid);
      if(userAlreadyRegister!) {
        getIt.get<UserRegisterUseCase>().fetchingUserDetails(uid).then((value) {
          LocalStorage.storeUserDetails(id: value!.id.toString(), name: value!.fullName.toString(), email: value!.email.toString(), username: value!.username.toString());
          if(value.imageUrl!=null) LocalStorage.setImageUrl(imageUrl: value.imageUrl.toString());
          Get.offAll(()=>const HomePage());
        }).onError((error, stackTrace) {
          if(kDebugMode) {
            print("firebase authentication error 95 : ${error.toString()}");
          }
        });
      } else {
        Get.offAll(()=>SignUpPageForGooglePhoneLoginMethod(email: email,));
      }
    }catch (error) {
      if(kDebugMode) print("checkUserAlreadyRegister ERROR : ${error.toString()}");
    }finally{
      SmartDialog.dismiss();
    }
  }
  Future<bool> forgetPassword(
      BuildContext context, String email) async {
    try {
     await auth.sendPasswordResetEmail(email: email);
     return true;
    } on FirebaseAuthException catch (error) {
      firebaseErrorHandler(error.code.toString());
      if(kDebugMode) print("forget password error : ${error.toString()}");
      return false;
    }
  }

  Future<bool> createUserAccount(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      firebaseErrorHandler(error.code.toString());
      if(kDebugMode) print("user created error : ${error.toString()}");
      return false;
    }
  }

  static void firebaseErrorHandler(String errorCode) {
    if(kDebugMode) print("firebase error handler  : $errorCode");
    switch (errorCode) {
      case "invalid-email":
        AppDialog.firebaseAuthExceptionDialog(AppConstantsText.invalidEmail,
            AppConstantsText.invalidEmailMessage);
        return;
      case "user-not-found":
        AppDialog.firebaseAuthExceptionDialog(AppConstantsText.userNotFound,
            AppConstantsText.userNotFoundMessage);
        return;
      case "wrong-password":
        AppDialog.firebaseAuthExceptionDialog(AppConstantsText.wrongPassword,
            AppConstantsText.wrongPasswordMessage);
        return;
      case "email-already-in-use":
        AppDialog.firebaseAuthExceptionDialog(
            AppConstantsText.emailAlreadyInUse,
            AppConstantsText.emailAlreadyInUseMessage);
        return;
      case "too-many-requests":
        AppDialog.firebaseAuthExceptionDialog(AppConstantsText.tooManyRequests,
            AppConstantsText.tooManyRequestsMessage);
        return;
      case "invalid-verification-code":
        AppDialog.firebaseAuthExceptionDialog(AppConstantsText.invalidVerificationCode,
            AppConstantsText.invalidVerificationCodeMessage);
        return;
      default:
        AppDialog.someThingWentWrongDialog();
        return;
    }
  }
}
