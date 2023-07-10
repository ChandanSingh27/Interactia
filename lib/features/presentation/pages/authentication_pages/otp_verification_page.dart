import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/screen_back_button.dart';
import 'package:taskhub/firebase/authentication/firebase_authentication.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_text.dart';

import '../../../../utility/constants_color.dart';
import '../../../../utility/constants_text_style.dart';
import '../../../../utility/constants_value.dart';

class OtpVerificationPage extends StatefulWidget {
  String mobileNumber;
  String verificationId;
  OtpVerificationPage({super.key, required this.mobileNumber,required this.verificationId});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {

  final TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LoginPageProvider>(context,listen: false).startTimer(30);
  }
  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: [
            const ScreenBackButton(),
            Padding(
              padding: EdgeInsets.all(AppConstants.constantsAppPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset(AppConstantsText.otpLottie, height: 250, width: 250),
                  Text(
                    AppConstantsText.confirmYourNumber,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    children: [
                      Text(
                        AppConstantsText.enterTheCode,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        widget.mobileNumber,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Pinput(
                    controller: pinController,
                    androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                    mainAxisAlignment: MainAxisAlignment.center,
                    onCompleted: (value) {
                      print("----> $value");
                    },
                    length: 6,
                    defaultPinTheme: PinTheme(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppConstantsColor.blackLight
                            : AppConstantsColor.grayAsh.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Consumer<LoginPageProvider>(builder: (context, loginProvider, child) => Column(
                    children: [
                      if(loginProvider.timerSeconds != 0 ) Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("00 : ${loginProvider.timerSeconds < 10 ? "0" : "" }${loginProvider.timerSeconds.toString()}",style: Theme.of(context).textTheme.bodySmall,),
                          const SizedBox(width: 5,),
                          Text(AppConstantsText.sec,style: Theme.of(context).textTheme.bodySmall,),
                          const SizedBox(width: 5,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppConstantsText.donTReceivedOTP,style: Theme.of(context).textTheme.bodySmall,),
                          const SizedBox(width: 4,),
                          TextButton(onPressed: (){}, child: Text(AppConstantsText.resendOTP,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: loginProvider.resendOTPButtonColorEnable?AppConstantsColor.blueLight:AppConstantsColor.matteBlack),)),
                        ],
                      )
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.constantsAppPadding,vertical: AppConstants.constantsAppPadding),
          child: CustomButton(onTap: (){
            print('tap');
            if(pinController.text.length == 6){
              getIt.get<FirebaseAuthentication>().verifyOTP(context, widget.verificationId, pinController.text.trim());
            }
          }, backgroundColor: AppConstantsColor.blueLight, text: AppConstantsText.verify, disableButton: false, loader: false),
        ),
      ),
    );
  }
}
