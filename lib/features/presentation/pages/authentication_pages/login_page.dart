import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/features/presentation/widgets/buttons/custom_icons_button.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'package:taskhub/utility/constants_value.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/text_style.dart';

import '../../widgets/buttons/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  enableOrDisableLoginButton(){
    if(emailController.text.isNotEmpty && passwordController.text.length>8){
      Provider.of<LoginPageProvider>(context,listen: false).loginButtonDisableToggle(false);
    }else{
      Provider.of<LoginPageProvider>(context,listen: false).loginButtonDisableToggle(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstantsColor.black,
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

                        Text(AppConstantsText.appName,style: AppConstantTextStyle.headingSemiBold_20(),),

                        const SizedBox(height: 40,),

                        Consumer<LoginPageProvider>(builder: (context, provider, child) => TextFormField(
                          controller: emailController,
                          style: AppConstantTextStyle.textFormFieldStyle(),
                          cursorColor: AppConstantsColor.appTextLightShadeColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppConstantsColor.blackLight,
                            contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.constantsAppPadding),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppConstantsColor.blackLight),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppConstantsColor.blackLight),
                            ),
                            hintText: AppConstantsText.email,
                            hintStyle: AppConstantTextStyle.textFormFieldStyle(),
                          ),
                          onChanged: (value) {
                            if(value.isNotEmpty && passwordController.text.length >= 8){
                              provider.loginButtonDisableToggle(false);
                            }else{
                              provider.loginButtonDisableToggle(true);
                            }
                          },
                        ),),
                        const SizedBox(height: 10,),

                        Consumer<LoginPageProvider>(builder: (context, provider, child) => TextFormField(
                          controller: passwordController,
                          style: AppConstantTextStyle.textFormFieldStyle(),
                          obscureText: provider.passwordVisible,
                          obscuringCharacter: "*",
                          cursorColor: AppConstantsColor.appTextLightShadeColor,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: AppConstantsColor.blackLight,
                              suffixIcon: Consumer<LoginPageProvider>(builder: (context, provider, child) => GestureDetector(onTap: () => provider.passwordVisibleToggle(),child: Icon(provider.passwordVisible?FontAwesome.eye_slash:FontAwesome.eye,color: provider.passwordVisible?AppConstantsColor.appTextLightShadeColor:AppConstantsColor.blueLight,size: 15,),)),
                              contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.constantsAppPadding),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppConstantsColor.blackLight),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppConstantsColor.blackLight),
                              ),
                              hintText: AppConstantsText.password,
                              hintStyle: AppConstantTextStyle.textFormFieldStyle()
                          ),
                          onChanged: (value) {
                            if(value.length >= 8 && emailController.text.isNotEmpty){
                              provider.loginButtonDisableToggle(false);
                            }else{
                              provider.loginButtonDisableToggle(true);
                            }
                          },
                        ),),
                        const SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){}, child: Text(AppConstantsText.forgetPassword))
                          ],
                        ),
                        const SizedBox(height: 10,),

                        Selector<LoginPageProvider, bool>(
                            builder: (context, loginButtonDisable, child) => CustomButton(onTap: (){},text: AppConstantsText.login,backgroundColor: AppConstantsColor.blueLight,disableButton: loginButtonDisable),
                            selector: (context, loginProvider) => loginProvider.loginButtonDisable,),

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
              Text(AppConstantsText.donTHaveAnAccount,style: AppConstantTextStyle.textFormFieldStyle(),),
              TextButton(onPressed: (){}, child: Text(AppConstantsText.signup))
            ],
          )
        ],
      ),
    );
  }
}
