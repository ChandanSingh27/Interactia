import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskhub/utility/constants_text.dart';

import '../../features/presentation/widgets/custom_dialog/app_dialogs.dart';
class FirebaseAuthentication{
    static FirebaseAuth auth = FirebaseAuth.instance;

     Future<bool> loginWithEmailPassword(BuildContext context,String email, String password) async{
       try{
         UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
         return true;
       }on FirebaseAuthException catch(error){
         firebaseErrorHandler(error.code.toString());
         print("error 1 : ${error.toString()}");
         return false;
       }
    }


    static void firebaseErrorHandler(String errorCode) {
      print("====> error : $errorCode" );
        switch(errorCode) {
          case "invalid-email": AppDialog.firebaseAuthExceptionDialog(AppConstantsText.invalidEmail,AppConstantsText.invalidEmailMessage); return;
          case "user-not-found": AppDialog.firebaseAuthExceptionDialog(AppConstantsText.userNotFound,AppConstantsText.userNotFoundMessage); return;
          case "wrong-password": AppDialog.firebaseAuthExceptionDialog(AppConstantsText.wrongPassword, AppConstantsText.wrongPasswordMessage); return;
          case "email-already-in-use": AppDialog.firebaseAuthExceptionDialog(AppConstantsText.emailAlreadyInUse,AppConstantsText.emailAlreadyInUseMessage); return;
          case "too-many-requests": AppDialog.firebaseAuthExceptionDialog(AppConstantsText.tooManyRequests,AppConstantsText.tooManyRequestsMessage); return;
          default: AppDialog.someThingWentWrongDialog(); return;
        }
    }
}