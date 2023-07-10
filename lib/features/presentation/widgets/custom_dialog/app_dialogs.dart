import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/constants_text.dart';

class AppDialog {

  static noInternetDialog(){
    return SmartDialog.show(builder: (context) {
        bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09),
          decoration: BoxDecoration(
            color: isDark ? AppConstantsColor.matteBlack : AppConstantsColor.darkWhite,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(AppConstantsText.noInternetConnection,height: 200,width: 200),
                Text(AppConstantsText.internetConnectionFail,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite : AppConstantsColor.matteBlack ,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                const SizedBox(height: 5,),
                Text(AppConstantsText.internetConnectionFailMessage,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite.withOpacity(0.5) : AppConstantsColor.matteBlack.withOpacity(0.5)),textAlign: TextAlign.center,),
                const SizedBox(height: 5,),
                Divider(color: AppConstantsColor.appTextLightShadeColor.withOpacity(0.7),),
                InkWell(onTap: (){SmartDialog.dismiss();},child: Container(margin: const EdgeInsets.only(top: 5),alignment: Alignment.center,child: Text(AppConstantsText.tryAgain,style: TextStyle(color: AppConstantsColor.blueLight),),),),
              ],
            ),
          ),
        );
    },clickMaskDismiss: false);
  }

  static firebaseAuthExceptionDialog(String title,String message){
    return SmartDialog.show(builder: (context) {
      bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09),
        decoration: BoxDecoration(
          color: isDark ? AppConstantsColor.matteBlack : AppConstantsColor.darkWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(AppConstantsText.wrongLottie,height: 100,width: 100),
              Text(title,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite : AppConstantsColor.matteBlack ,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              const SizedBox(height: 5,),
              Text(message,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite.withOpacity(0.5) : AppConstantsColor.matteBlack.withOpacity(0.5)),textAlign: TextAlign.center,),
              const SizedBox(height: 5,),
              Divider(color: AppConstantsColor.appTextLightShadeColor.withOpacity(0.7),),
              InkWell(onTap: (){SmartDialog.dismiss();},child: Container(margin: const EdgeInsets.only(top: 5),alignment: Alignment.center,child: Text(AppConstantsText.tryAgain,style: TextStyle(color: AppConstantsColor.blueLight),),),),
            ],
          ),
        ),
      );
    },clickMaskDismiss: false);
  }

  static invalidDialog(String title,String message){
    return SmartDialog.show(builder: (context) {
      bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09),
        decoration: BoxDecoration(
          color: isDark ? AppConstantsColor.matteBlack : AppConstantsColor.darkWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(AppConstantsText.wrongLottie,height: 100,width: 100),
              Text(title,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite : AppConstantsColor.matteBlack ,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              const SizedBox(height: 5,),
              Text(message,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite.withOpacity(0.5) : AppConstantsColor.matteBlack.withOpacity(0.5)),textAlign: TextAlign.center,),
              const SizedBox(height: 5,),
              Divider(color: AppConstantsColor.appTextLightShadeColor.withOpacity(0.7),),
              InkWell(onTap: (){SmartDialog.dismiss();},child: Container(margin: const EdgeInsets.only(top: 5),alignment: Alignment.center,child: Text(AppConstantsText.tryAgain,style: TextStyle(color: AppConstantsColor.blueLight),),),),
            ],
          ),
        ),
      );
    },clickMaskDismiss: false);
  }

  static successDialog(BuildContext buildContext,String title,String message,String lottie ){
    return SmartDialog.show(builder: (context) {
      bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09),
        decoration: BoxDecoration(
          color: isDark ? AppConstantsColor.matteBlack : AppConstantsColor.darkWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(lottie,height: 100,width: 100),
              Text(title,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite : AppConstantsColor.matteBlack ,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              const SizedBox(height: 5,),
              Text(message,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite.withOpacity(0.5) : AppConstantsColor.matteBlack.withOpacity(0.5)),textAlign: TextAlign.center,),
              const SizedBox(height: 5,),
              Divider(color: AppConstantsColor.appTextLightShadeColor.withOpacity(0.7),),
              InkWell(onTap: (){
                SmartDialog.dismiss();
                Navigator.pop(buildContext);
                },child: Container(margin: const EdgeInsets.only(top: 5),alignment: Alignment.center,child: Text(AppConstantsText.done,style: TextStyle(color: AppConstantsColor.blueLight),),),),
            ],
          ),
        ),
      );
    },clickMaskDismiss: false);
  }

  static someThingWentWrongDialog(){
    return SmartDialog.show(builder: (context) {
      bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09),
        decoration: BoxDecoration(
          color: isDark ? AppConstantsColor.matteBlack : AppConstantsColor.darkWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(AppConstantsText.someThingWentWrongLottie,height: 100,width: 100),
              Text(AppConstantsText.someThingWentWrong,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite : AppConstantsColor.matteBlack ,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              const SizedBox(height: 5,),
              Text(AppConstantsText.someThingWentWrongMessage,style: TextStyle(color: isDark ? AppConstantsColor.darkWhite.withOpacity(0.5) : AppConstantsColor.matteBlack.withOpacity(0.5)),textAlign: TextAlign.center,),
              const SizedBox(height: 5,),
              Divider(color: AppConstantsColor.appTextLightShadeColor.withOpacity(0.7),),
              InkWell(onTap: (){SmartDialog.dismiss();},child: Container(margin: const EdgeInsets.only(top: 5),alignment: Alignment.center,child: Text(AppConstantsText.tryAgain,style: TextStyle(color: AppConstantsColor.blueLight),),),),
            ],
          ),
        ),
      );
    },clickMaskDismiss: false);
  }

}