
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/common/local_storage.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/signup_provider.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/profile_photo_upload_page.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/screen_back_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:taskhub/firebase/authentication/firebase_authentication.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'package:taskhub/utility/constants_text_style.dart';
import 'package:taskhub/utility/constants_value.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: ListView(
        children: [
          const ScreenBackButton(),
          Padding(
              padding: EdgeInsets.only(left:AppConstants.constantsAppPadding,right: AppConstants.constantsAppPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset("assets/lottie/sign_up.json",width: 200,height: 200),
                  Text(
                    AppConstantsText.createAccount,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    "Please enter your credentials to proceeds.",
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
                    onEditingComplete: () => FocusScope.of(context).requestFocus(passwordFocusNode),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    AppConstantsText.password,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: isDark?Colors.white:Colors.black),
                  ),
                  const SizedBox(height: 5,),
                  Consumer<SignUpProvider>(builder: (context, signUpProvider, child) => TextFormField(
                    controller: passwordController,
                    style: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
                    cursorColor: AppConstantsColor.appTextLightShadeColor,
                    focusNode: passwordFocusNode,
                    obscureText: signUpProvider.passwordNotVisible,
                    obscuringCharacter: 'x',
                    decoration: InputDecoration(
                        suffixIcon: IconButton(onPressed: (){signUpProvider.passwordVisibleToggle();},icon: Icon(signUpProvider.passwordNotVisible?FontAwesome.eye_slash:FontAwesome.eye,color: signUpProvider.passwordNotVisible?AppConstantsColor.appTextLightShadeColor:AppConstantsColor.blueLight,size: 15,),),
                        hintText: AppConstantsText.password
                    ),
                    onEditingComplete: () => FocusScope.of(context).requestFocus(confirmPasswordFocusNode),
                  ),),
                  const SizedBox(height: 10,),
                  Text(
                    AppConstantsText.confirmPassword,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: isDark?Colors.white:Colors.black),
                  ),
                  const SizedBox(height: 5,),
                  Consumer<SignUpProvider>(builder: (context, signUpProvider, child) {
                      return TextFormField(
                        controller: confirmPasswordController,
                        style: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
                        cursorColor: AppConstantsColor.appTextLightShadeColor,
                        focusNode: confirmPasswordFocusNode,
                        obscureText: signUpProvider.confirmPasswordNotVisible,
                        obscuringCharacter: 'x',
                        decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){signUpProvider.confirmPasswordVisibleToggle();},icon: Icon(signUpProvider.confirmPasswordNotVisible?FontAwesome.eye_slash:FontAwesome.eye,color: signUpProvider.confirmPasswordNotVisible?AppConstantsColor.appTextLightShadeColor:AppConstantsColor.blueLight,size: 15,),),
                            hintText: AppConstantsText.confirmPassword
                        ),
                        onEditingComplete: () => FocusScope.of(context).unfocus(),
                      );
                  },)
                  ],
              ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.constantsAppPadding,vertical: AppConstants.constantsAppPadding),
        child: CustomButton(onTap: (){
              if(getIt.get<InternetCheckingService>().isConnected){
                if(emailController.text.isEmpty || usernameController.text.isEmpty || fullNameController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty){
                    AppDialog.invalidDialog("Empty field can't process.", "Please enter the following details.");
                }else if(passwordController.text.length < 8) {
                  AppDialog.invalidDialog("Password length greater than 8", "Please enter the password length should be greater than 8.");
                }else if(passwordController.text != confirmPasswordController.text){
                  AppDialog.invalidDialog("Password doesn't Match ", "Please enter the matching password.");
                }else{
                  getIt.get<FirebaseAuthentication>().createUserAccount(context, emailController.text.trim(), passwordController.text.trim()).then((value) {
                    if(value){
                      LocalStorage.storeUserDetails(id: FirebaseAuth.instance.currentUser!.uid, name: fullNameController.text.trim(), email: emailController.text.trim(), username: usernameController.text.trim());
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilePhotoUploadPage(),));}
                  });
                }
              }else{
                AppDialog.noInternetDialog();
              }
        }, backgroundColor: AppConstantsColor.blueLight, text: "Create Account", disableButton: false, loader: false),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    usernameFocusNode.dispose();

  }
}
