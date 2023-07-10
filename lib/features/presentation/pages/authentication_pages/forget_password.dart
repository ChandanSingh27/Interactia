import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/screen_back_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:taskhub/firebase/authentication/firebase_authentication.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'package:taskhub/utility/constants_value.dart';

import '../../../../utility/constants_text_style.dart';
import '../../manager/login_page_provider.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController forgetEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const ScreenBackButton(),
          forgetPasswordContent(context),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: AppConstants.constantsAppPadding,right: AppConstants.constantsAppPadding,bottom: AppConstants.constantsAppPadding),
        child: CustomButton(onTap: (){
          if(getIt.get<InternetCheckingService>().isConnected){
            if(forgetEmailController.text.isEmpty){
              AppDialog.invalidDialog("Empty field can't process.", "Please enter the following details.");
            }
            else {
              getIt.get<FirebaseAuthentication>().forgetPassword(context, forgetEmailController.text.trim()).then((value) {if(value) AppDialog.successDialog(context,AppConstantsText.successFullyRestEmailSent, AppConstantsText.successFullyRestEmailSentMessage, AppConstantsText.sendEmailLottie);});
            }
          }else{
            AppDialog.noInternetDialog();
          }
        }, backgroundColor: AppConstantsColor.blueLight, text: AppConstantsText.submit, disableButton: false, loader: false),
      ),
    );
  }

  Widget forgetPasswordContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(AppConstants.constantsAppPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(AppConstantsText.forgetPasswordLottie, height: 250, width: 250),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppConstantsText.forgetPassword,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            AppConstantsText.forgetPasswordMessage,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 30,
          ),
          Consumer<LoginPageProvider>(
            builder: (context, loginProvider, child) => TextFormField(
              // controller: phoneController,
              controller: forgetEmailController,
              style: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
              cursorColor: AppConstantsColor.appTextLightShadeColor,
              decoration: InputDecoration(
                  hintText: AppConstantsText.email
              ),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onChanged: (value) {
              },
            ),
          ),
        ],
      ),
    );
  }
}
