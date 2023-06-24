import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/custom_button.dart';
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
    final isLight = MediaQuery.of(context).platformBrightness ==
        Brightness.light;

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
          icon: Icon(CupertinoIcons.back,color: isLight?AppConstantsColor.black:AppConstantsColor.white,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.constantsAppPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            phoneNumberTextFieldWidget(isLight,countryPicker),
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Consumer<LoginPageProvider>(builder: (context, loginProvider, child) => CustomButton(
                    onTap: () {
                      loginProvider.toggleEnableSendMeCodeButtonLoader();
                      Future.delayed(const Duration(seconds: 3),() => loginProvider.toggleEnableSendMeCodeButtonLoader(),);
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

  Widget phoneNumberTextFieldWidget(bool isLight, FlCountryCodePicker countryPicker){
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
              color: isLight
                  ? AppConstantsColor.grayAsh.withOpacity(0.3)
                  : AppConstantsColor.blackLight,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Consumer<LoginPageProvider>(builder: (context, loginPageProvider, child) => GestureDetector(
                  onTap: () async{
                    await countryPicker.showPicker(
                      context: context,
                      backgroundColor: isLight ? AppConstantsColor.darkWhite : AppConstantsColor.matteBlack,
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
                  style: isLight ? AppConstantTextStyle.formFieldTextStyleBlack() : AppConstantTextStyle.formFieldTextStyleWhite(),
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
