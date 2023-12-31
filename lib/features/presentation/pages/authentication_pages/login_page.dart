import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/data/data_sources/fetch_user_data.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/features/presentation/manager/theme_provider.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/forget_password.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/sign_up_page.dart';
import 'package:taskhub/features/presentation/pages/home_page.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:taskhub/firebase/authentication/firebase_authentication.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'package:taskhub/utility/constants_value.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/constants_text_style.dart';
import '../../../../common/local_storage.dart';
import '../../../domain/use_cases/user_register_use_case.dart';
import '../../widgets/custom_buttons/custom_button.dart';
import '../../widgets/custom_buttons/custom_icons_button.dart';
import 'login_with_phone_page.dart';

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
      body: Padding(
        padding: EdgeInsets.all(AppConstants.constantsAppPadding),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppConstantsText.appName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Consumer2<LoginPageProvider, ThemeProvider>(
                    builder: (context, provider, themeProvider, child) {
                      bool isDark = themeProvider.appThemeMode == ThemeMode.dark;
                      return TextFormField(
                        controller: emailController,
                        style: isDark
                            ? AppConstantTextStyle.formFieldTextStyleWhite()
                            : AppConstantTextStyle.formFieldTextStyleBlack(),
                        cursorColor: AppConstantsColor.appTextLightShadeColor,
                        focusNode: emailFocus,
                        decoration:
                            InputDecoration(hintText: AppConstantsText.email),
                        onChanged: (value) {
                          if (value.isNotEmpty &&
                              passwordController.text.length >= 8) {
                            provider.isLoadingButtonEnable(false);
                          } else {
                            provider.isLoadingButtonEnable(true);
                          }
                        },
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(passwordFocus),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer2<LoginPageProvider, ThemeProvider>(
                    builder: (context, provider, themeProvider, child) {
                      bool isDark =
                          themeProvider.appThemeMode == ThemeMode.dark;
                      return TextFormField(
                        controller: passwordController,
                        style: isDark
                            ? AppConstantTextStyle.formFieldTextStyleWhite()
                            : AppConstantTextStyle.formFieldTextStyleBlack(),
                        focusNode: passwordFocus,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: provider.passwordVisible,
                        obscuringCharacter: "x",
                        cursorColor: AppConstantsColor.appTextLightShadeColor,
                        decoration: InputDecoration(
                          suffixIcon: Consumer<LoginPageProvider>(
                              builder: (context, provider, child) =>
                                  GestureDetector(
                                    onTap: () =>
                                        provider.passwordVisibleToggle(),
                                    child: Icon(
                                      provider.passwordVisible
                                          ? FontAwesome.eye_slash
                                          : FontAwesome.eye,
                                      color: provider.passwordVisible
                                          ? AppConstantsColor
                                              .appTextLightShadeColor
                                          : AppConstantsColor.blueLight,
                                      size: 15,
                                    ),
                                  )),
                          hintText: AppConstantsText.password,
                        ),
                        onChanged: (value) {
                          if (value.length >= 8 &&
                              emailController.text.isNotEmpty) {
                            provider.isLoadingButtonEnable(false);
                          } else {
                            provider.isLoadingButtonEnable(true);
                          }
                        },
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.to(() => const ForgetPasswordPage(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(seconds: 1));
                          },
                          child: Text(AppConstantsText.forgetPassword))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer2<LoginPageProvider, InternetCheckingService>(
                    builder: (context, provider, internetProvider, child) =>
                        CustomButton(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              if (internetProvider.isConnected) {
                                provider.isLoadingButtonEnable(true);
                                provider.loadingLoaderToggle();
                                getIt
                                    .get<FirebaseAuthentication>()
                                    .loginWithEmailPassword(
                                        context,
                                        emailController.text.trim(),
                                        passwordController.text.trim())
                                    .then((value) {
                                  if (value) {
                                    print(
                                        "-----------------${FirebaseAuth.instance.currentUser!.uid}");
                                    getIt
                                        .get<UserRegisterUseCase>()
                                        .fetchingUserDetails(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .then((value) {
                                      LocalStorage.storeUserDetails(
                                          id: value!.id.toString(),
                                          name: value!.fullName.toString(),
                                          email: value!.email.toString(),
                                          username: value!.username.toString());
                                      if (value.imageUrl != null)
                                        LocalStorage.setImageUrl(
                                            imageUrl:
                                                value.imageUrl.toString());
                                      Get.offAll(() => const HomePage());
                                    }).onError((error, stackTrace) {
                                      if (kDebugMode) {
                                        print(
                                            "firebase authentication error login page 126 : ${error.toString()}");
                                      }
                                    });
                                  }
                                });
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () => provider.loadingLoaderToggle(),
                                );
                              } else {
                                AppDialog.noInternetDialog();
                              }
                            },
                            text: AppConstantsText.login,
                            backgroundColor: AppConstantsColor.blueLight,
                            disableButton: provider.loginButtonDisable,
                            loader: provider.loginButtonLoader),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: AppConstantsColor.appTextLightShadeColor,
                      )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            AppConstantsText.orContinueWith,
                            style: TextStyle(
                                color:
                                    AppConstantsColor.appTextLightShadeColor),
                          )),
                      Expanded(
                          child: Divider(
                        color: AppConstantsColor.appTextLightShadeColor,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<LoginPageProvider>(
                    builder: (context, loginProvider, child) {
                      return CustomIconButton(
                        onTap: () async {
                          try {
                            loginProvider
                                .toggleEnableContinueWithGoogleButtonAndLoader();
                            await getIt
                                .get<FirebaseAuthentication>()
                                .googleSigning(context);
                          } catch (error) {
                            print("google button error$error");
                          } finally {
                            Future.delayed(
                              const Duration(seconds: 2),
                              () => loginProvider
                                  .toggleEnableContinueWithGoogleButtonAndLoader(),
                            );
                          }
                        },
                        text: AppConstantsText.continueWithGoogle,
                        icon: Logo(Logos.google),
                        backgroundColor: Colors.white,
                        enableButton:
                            loginProvider.enableContinueWithGoogleButton,
                        loader: loginProvider.continueWithGoogleButtonLoader,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<LoginPageProvider>(
                    builder: (context, loginProvider, child) {
                      return CustomIconButton(
                        onTap: () {
                          try {
                            loginProvider
                                .toggleEnableContinueWithPhoneButtonAndLoader();
                            Get.to(() => const LoginWithPhone(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(seconds: 1));
                          } catch (error) {
                            print("phone button error$error");
                          } finally {
                            Future.delayed(
                              const Duration(seconds: 5),
                              () => loginProvider
                                  .toggleEnableContinueWithPhoneButtonAndLoader(),
                            );
                          }
                        },
                        text: AppConstantsText.continueWithPhone,
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        backgroundColor: AppConstantsColor.blueLight,
                        textColor: Colors.white,
                        loader: loginProvider.continueWithPhoneButtonLoader,
                        enableButton:
                            loginProvider.enableContinueWithPhoneButton,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Consumer<ThemeProvider>(
        builder:(context, themeProvider, child) {
          bool isDark = themeProvider.appThemeMode == ThemeMode.dark;
          return Padding(
            padding: EdgeInsets.only(
                right: AppConstants.constantsAppPadding,
                left: AppConstants.constantsAppPadding,
                bottom: AppConstants.constantsAppPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: AppConstantsColor.appTextLightShadeColor,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppConstantsText.donTHaveAnAccount,
                      style: isDark
                          ? AppConstantTextStyle.formFieldTextStyleWhite()
                          : AppConstantTextStyle.formFieldTextStyleBlack(),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const SignUpPage(),
                              transition: Transition.downToUp,
                              duration: const Duration(seconds: 1));
                        },
                        child: Text(AppConstantsText.signup))
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }
}
