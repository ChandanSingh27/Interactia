import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/otp_verification_page.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:taskhub/features/presentation/widgets/left_top_blue_shadow.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'package:taskhub/utility/constants_value.dart';
import '../../../../utility/constants_color.dart';
import '../../../../utility/constants_text_style.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {

  final TextEditingController phoneController = TextEditingController();

  FocusNode phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness ==
        Brightness.dark;

    final countryPicker = FlCountryCodePicker(
      countryTextStyle: Theme.of(context).textTheme.bodySmall,
      showSearchBar: false,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back,color: isDark ? AppConstantsColor.white : AppConstantsColor.black,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.constantsAppPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            phoneNumberTextFieldWidget(isDark,countryPicker),
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Consumer2<LoginPageProvider,InternetCheckingService>(builder: (context, loginProvider, internetConnection,child) => CustomButton(
                    onTap: () {
                      String countryCodeMobileNumber = loginProvider.countryCode.toString() + phoneController.text.trim();
                      if(internetConnection.isConnected){
                        loginProvider.toggleEnableSendMeCodeButtonLoader();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerificationPage(mobileNumber: countryCodeMobileNumber),));
                        loginProvider.toggleEnableSendMeCodeButtonLoader();
                      }else{
                        AppDialog.noInternetDialog();
                      }
                    },
                    backgroundColor: AppConstantsColor.blueLight,
                    text: AppConstantsText.sendMeCode,
                    disableButton: loginProvider.disableSendMeCodeButton,
                    loader: loginProvider.sendMeCodeLoader),)),
          ],
        ),
      ),
    );
  }

  Widget phoneNumberTextFieldWidget(bool isDark, FlCountryCodePicker countryPicker){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Lottie.asset(AppConstantsText.signUpLottie,height: 250,width: 250),
        Text(
          AppConstantsText.enterYourPhoneNo,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          AppConstantsText.sendOTPVerification,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.constantsAppPadding),
          decoration: BoxDecoration(
              color: isDark
                  ? AppConstantsColor.blackLight
                  : AppConstantsColor.grayAsh.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Consumer<LoginPageProvider>(builder: (context, loginPageProvider, child) => GestureDetector(
                  onTap: () async{
                    await countryPicker.showPicker(
                      context: context,
                      backgroundColor: isDark ? AppConstantsColor.matteBlack : AppConstantsColor.darkWhite,
                      pickerMaxHeight: 600,
                      initialSelectedLocale: 'In',
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none
                      ),
                    ).then((value) {
                      if(value != null){
                        loginPageProvider.setCountryCode(value.dialCode);
                      }
                      FocusScope.of(context).requestFocus(phoneFocusNode);
                    });
                  },
                  child: Text(loginPageProvider.countryCode)),),
              const SizedBox(
                height: 30,
                child: VerticalDivider(thickness: 2),
              ),
              Expanded(
                child: Consumer<LoginPageProvider>(builder: (context, loginProvider, child) => TextFormField(
                  controller: phoneController,
                  style: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
                  cursorColor: AppConstantsColor.appTextLightShadeColor,
                  keyboardType: TextInputType.phone,
                  textAlignVertical: TextAlignVertical.center,
                  focusNode: phoneFocusNode,
                  maxLength: 10,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintStyle: AppConstantTextStyle.formFieldHintTextStyle(),
                      hintText: AppConstantsText.phoneNumber,
                      counterText: "",
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.zero
                  ),
                  onChanged: (value) {
                    if(value.length == 10){
                      loginProvider.toggleEnableSendMeCodeButton(false);
                    }
                    else{
                      loginProvider.toggleEnableSendMeCodeButton(true);
                    }
                  },
                  onTapOutside: (event) =>
                      FocusScope.of(context).unfocus(),
                ),),
              ),
            ],
          ),
        )
      ],
    );
  }
}
