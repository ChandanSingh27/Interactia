import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/otp_verification_page.dart';
import 'package:taskhub/features/presentation/pages/home_page.dart';
import 'package:taskhub/utility/constants_text.dart';

import '../../features/presentation/widgets/custom_dialog/app_dialogs.dart';

class FirebaseAuthentication {
  static FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> loginWithEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpVerificationPage(
                        mobileNumber: phoneNumber,
                        verificationId: verificationId),
                  ));
            },
            codeAutoRetrievalTimeout: (verificationId) {});
  }

  Future<bool> verifyOTP(
      BuildContext context, String verificationId, String otpCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpCode);
      await auth.signInWithCredential(credential).then((value) => Navigator.push(context, CupertinoPageRoute(builder: (context) => const HomePage(),)));
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
        return Navigator.push(context, CupertinoPageRoute(builder: (context) => const HomePage(),));
      });
    }on FirebaseAuthException catch(error) {
      firebaseErrorHandler(error.code.toString());
      if(kDebugMode) print("google signing error : ${error.toString()}");
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
      default:
        AppDialog.someThingWentWrongDialog();
        return;
    }
  }
}
