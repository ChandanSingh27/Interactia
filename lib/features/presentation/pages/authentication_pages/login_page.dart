import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:taskhub/firebase/authentication/firebase_authentication.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'package:taskhub/utility/constants_value.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/text_style.dart';
import '../../widgets/custom_buttons/custom_button.dart';
import '../../widgets/custom_buttons/custom_icons_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: -100,
              top: -100,
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppConstantsColor.blueLight.withOpacity(0.4),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 500,
                      ),
                      BoxShadow(
                        color: AppConstantsColor.blueLight.withOpacity(0.4),
                        blurStyle: BlurStyle.inner,
                        blurRadius: 500,
                      )
                    ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppConstants.constantsAppPadding),
              child: Form(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Text(AppConstantsText.appName,style: Theme.of(context).textTheme.titleLarge,),

                        const SizedBox(height: 40,),

                        Consumer<LoginPageProvider>(builder: (context, provider, child) => TextFormField(
                          controller: emailController,
                          style: AppConstantTextStyle.formFieldTextStyle(),
                          cursorColor: AppConstantsColor.appTextLightShadeColor,
                          focusNode: emailFocus,
                          decoration: InputDecoration(
                              hintText: AppConstantsText.email
                          ),
                          onChanged: (value) {
                            if(value.isNotEmpty && passwordController.text.length >= 8){
                              provider.isLoadingButtonEnable(false);
                            }else{
                              provider.isLoadingButtonEnable(true);
                            }
                          },
                          onEditingComplete: () => FocusScope.of(context).requestFocus(passwordFocus),
                        ),),
                        const SizedBox(height: 10,),

                        Consumer<LoginPageProvider>(builder: (context, provider, child) => TextFormField(
                          controller: passwordController,
                          style: AppConstantTextStyle.formFieldTextStyle(),
                          focusNode: passwordFocus,
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: provider.passwordVisible,
                          obscuringCharacter: "x",
                          cursorColor: AppConstantsColor.appTextLightShadeColor,
                          decoration: InputDecoration(
                              suffixIcon: Consumer<LoginPageProvider>(builder: (context, provider, child) => GestureDetector(onTap: () => provider.passwordVisibleToggle(),child: Icon(provider.passwordVisible?FontAwesome.eye_slash:FontAwesome.eye,color: provider.passwordVisible?AppConstantsColor.appTextLightShadeColor:AppConstantsColor.blueLight,size: 15,),)),
                              hintText: AppConstantsText.password,
                          ),
                          onChanged: (value) {
                            if(value.length >= 8 && emailController.text.isNotEmpty){
                              provider.isLoadingButtonEnable(false);
                            }else{
                              provider.isLoadingButtonEnable(true);
                            }
                          },
                          onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        ),),
                        const SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){}, child: Text(AppConstantsText.forgetPassword))
                          ],
                        ),
                        const SizedBox(height: 10,),

                        Consumer2<LoginPageProvider,InternetCheckingService>(builder: (context, provider, internetProvider, child) => CustomButton(onTap: (){
                          FocusScope.of(context).unfocus();
                          if(internetProvider.isConnected){
                            provider.isLoadingButtonEnable(true);
                            provider.loadingLoaderToggle();
                            FirebaseAuthentication.loginWithEmailPassword(emailController.text.trim(), passwordController.text.trim());
                            Future.delayed(const Duration(seconds: 2),() => provider.loadingLoaderToggle(),);
                          }else{
                            AppDialog.noInternetDialog();
                          }
                        },text: AppConstantsText.login,backgroundColor: AppConstantsColor.blueLight,disableButton: provider.loginButtonDisable,loader: provider.loadingLoader),),

                        const SizedBox(height: 20,),

                        Row(
                          children: [
                            Expanded(child: Divider(color: AppConstantsColor.appTextLightShadeColor,)),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 5),child: Text(AppConstantsText.orContinueWith,style: TextStyle(color: AppConstantsColor.appTextLightShadeColor),)),
                            Expanded(child: Divider(color: AppConstantsColor.appTextLightShadeColor,)),
                          ],
                        ),

                        const SizedBox(height: 20,),
                        CustomIconButton(onTap: (){}, text: AppConstantsText.continueWithGoogle,icon: Logo(Logos.google),backgroundColor: Colors.white,),
                        const SizedBox(height: 15,),
                        CustomIconButton(onTap: (){}, text: AppConstantsText.continueWithPhone,icon: const Icon(Icons.phone,color: Colors.white,),backgroundColor: AppConstantsColor.blueLight,textColor: Colors.white,)

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: AppConstantsColor.appTextLightShadeColor,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppConstantsText.donTHaveAnAccount,style: AppConstantTextStyle.formFieldTextStyle(),),
              TextButton(onPressed: (){}, child: Text(AppConstantsText.signup))
            ],
          )
        ],
      ),
    );
  }
}
