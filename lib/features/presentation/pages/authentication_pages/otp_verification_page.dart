import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/utility/constants_text.dart';

import '../../../../utility/constants_color.dart';
import '../../../../utility/constants_text_style.dart';
import '../../../../utility/constants_value.dart';

class OtpVerificationPage extends StatefulWidget {
  String mobileNumber;
  OtpVerificationPage({super.key, required this.mobileNumber});

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            color: isDark ? AppConstantsColor.white : AppConstantsColor.black,
          ),
        ),
      ),
      body: Padding(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(loginProvider.timerSeconds != 0 ) Text("00 : ${loginProvider.timerSeconds < 10 ? "0" : "" }${loginProvider.timerSeconds.toString()}",style: Theme.of(context).textTheme.bodySmall,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't recieve the OTP?",style: Theme.of(context).textTheme.bodySmall,),
                    const SizedBox(width: 4,),
                    TextButton(onPressed: (){}, child: Text("Resend OTP",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: loginProvider.resendOTPButtonColorEnable?AppConstantsColor.blueLight:AppConstantsColor.matteBlack),)),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
