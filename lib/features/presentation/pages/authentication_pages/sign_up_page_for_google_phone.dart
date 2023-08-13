
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';
import 'package:taskhub/features/domain/use_cases/user_register_use_case.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/signup_provider.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/profile_photo_upload_page.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/screen_back_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:taskhub/firebase/authentication/firebase_authentication.dart';
import 'package:taskhub/firebase/push_notification/push_notification.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'package:taskhub/utility/constants_text_style.dart';
import 'package:taskhub/utility/constants_value.dart';

import '../../../../common/local_storage.dart';
class SignUpPageForGooglePhoneLoginMethod extends StatefulWidget {
  String? email;
  SignUpPageForGooglePhoneLoginMethod({super.key,this.email});

  @override
  State<SignUpPageForGooglePhoneLoginMethod> createState() => _SignUpPageForGooglePhoneLoginMethodState();
}

class _SignUpPageForGooglePhoneLoginMethodState extends State<SignUpPageForGooglePhoneLoginMethod> {

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.email!.isNotEmpty) emailController.text = widget.email!;
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: AppConstants.constantsAppPadding,left:AppConstants.constantsAppPadding,right: AppConstants.constantsAppPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.asset(AppConstantsText.signUpLottie,width: 200,height: 200),
                Text(
                  AppConstantsText.createAccount,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5,),
                Text(
                  AppConstantsText.pleaseEnterYourCredentialsToProceeds,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 25,),
                Text(
                  AppConstantsText.fullName,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: isDark?Colors.white:Colors.black),
                ),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: fullNameController,
                  style: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
                  cursorColor: AppConstantsColor.appTextLightShadeColor,
                  focusNode: fullNameFocusNode,
                  decoration: InputDecoration(
                      hintText: AppConstantsText.name
                  ),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(usernameFocusNode),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                ),
                const SizedBox(height: 10,),
                Text(
                  AppConstantsText.userName,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: isDark?Colors.white:Colors.black),
                ),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: usernameController,
                  style: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
                  cursorColor: AppConstantsColor.appTextLightShadeColor,
                  focusNode: usernameFocusNode,
                  decoration: InputDecoration(
                      hintText: AppConstantsText.userNameHintText
                  ),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(emailFocusNode),
                ),
                const SizedBox(height: 10,),
                Text(
                  AppConstantsText.email,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: isDark?Colors.white:Colors.black),
                ),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: emailController,
                  style: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
                  cursorColor: AppConstantsColor.appTextLightShadeColor,
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                      hintText: AppConstantsText.email
                  ),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
                const SizedBox(height: 10,),
                ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.constantsAppPadding,vertical: AppConstants.constantsAppPadding),
        child: CustomButton(onTap: () async{
          if(getIt.get<InternetCheckingService>().isConnected){
            if(emailController.text.isEmpty || usernameController.text.isEmpty || fullNameController.text.isEmpty ){
              AppDialog.invalidDialog("Empty field can't process.", "Please enter the following details.");
            }else{
              AppDialog.processingDialog("Account Creating...");
              String? fcm = await PushNotification.getToken();
              UserDetailsModel model = UserDetailsModel(
                id: FirebaseAuth.instance.currentUser!.uid,
                fullName: fullNameController.text.trim(),
                email: emailController.text.trim(),
                fcmToken: fcm,
                username: usernameController.text.trim()
              );
              print("######################################################${model.toJson()}");
              // api calling
              getIt.get<UserRegisterUseCase>().createNewUserUseCase(model.toJson()).then((value) {
                if(value!){
                  LocalStorage.storeUserDetails(id: model.id.toString(), name: model.fullName.toString(), email: model.email.toString(), username: model.username.toString());
                  SmartDialog.dismiss();
                  Get.offAll(()=>const ProfilePhotoUploadPage(),transition: Transition.rightToLeft,duration: const Duration(seconds: 1));
                }else{
                  SmartDialog.dismiss();
                  AppDialog.someThingWentWrongDialog();
                }
              }).onError((error, stackTrace) => SmartDialog.dismiss() as Future<Null>);
            }
          }else{
            AppDialog.noInternetDialog();
          }
        }, backgroundColor: AppConstantsColor.blueLight, text: AppConstantsText.createAccountButton, disableButton: false, loader: false),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    usernameFocusNode.dispose();

  }
}
