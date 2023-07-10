import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/signup_provider.dart';
import 'package:taskhub/features/presentation/pages/home_page.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/screen_back_button.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'package:taskhub/utility/constants_value.dart';

class ProfilePhotoUploadPage extends StatefulWidget {
  const ProfilePhotoUploadPage({super.key});

  @override
  State<ProfilePhotoUploadPage> createState() => _ProfilePhotoUploadPageState();
}

class _ProfilePhotoUploadPageState extends State<ProfilePhotoUploadPage> {
  File? file;
  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ScreenBackButton(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.constantsAppPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppConstantsText.addAProfilePhoto,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    AppConstantsText.addAProfilePhotoMessage,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Consumer<SignUpProvider>(
              builder: (context, signUpProvider, child) {
                return signUpProvider.profilePhotoFile != null
                    ? Container(
                        width: 200,
                        height: 200,
                        margin: EdgeInsets.only(
                            top: AppConstants.constantsAppPadding * 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    FileImage(signUpProvider.profilePhotoFile!),
                                fit: BoxFit.cover)),
                      )
                    : Lottie.asset(AppConstantsText.profilePhotoLottie,
                        width: 300, height: 300);
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppConstants.constantsAppPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
                onTap: () {
                  imageSourceDialog(isDark);
                },
                backgroundColor: AppConstantsColor.blueLight,
                text: "Choose a photo",
                disableButton: false,
                loader: false),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                  AppDialog.successDialog(
                      context,
                      "Successfully Account Create",
                      "Your account successfully created in our application.",
                      "assets/lottie/success_lottie.json");
                },
                backgroundColor: AppConstantsColor.darkWhite,
                text: AppConstantsText.mayBeLater,
                disableButton: false,
                loader: false)
          ],
        ),
      ),
    );
  }

  imageSourceDialog(bool isDark) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding:
            EdgeInsets.symmetric(horizontal: AppConstants.constantsAppPadding),
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 6,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onTap: () {
                  selectProfileImage(ImageSource.camera, isDark);
                  Navigator.pop(context);
                },
                backgroundColor: AppConstantsColor.blueLight,
                text: AppConstantsText.takeAPhoto,
                disableButton: false,
                loader: false),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onTap: () {
                  selectProfileImage(ImageSource.gallery, isDark);
                  Navigator.pop(context);
                },
                backgroundColor: AppConstantsColor.darkWhite,
                text: AppConstantsText.addFromLibrary,
                disableButton: false,
                loader: false)
          ],
        ),
      ),
    );
  }

  selectProfileImage(ImageSource source, bool isDark) async {
    final picker = ImagePicker();
    final cropper = ImageCropper();
    final image = await picker.pickImage(source: source);
    CroppedFile? croppedFile = await cropper
        .cropImage(sourcePath: image!.path, compressQuality: 50, uiSettings: [
      AndroidUiSettings(
          activeControlsWidgetColor: AppConstantsColor.blueLight,
          toolbarWidgetColor:
              isDark ? AppConstantsColor.white : AppConstantsColor.black,
          toolbarColor:
              isDark ? AppConstantsColor.black : AppConstantsColor.white),
    ]);
    if (croppedFile != null) {
      Provider.of<SignUpProvider>(context,listen: false)
          .updateProfilePhoto(File(croppedFile!.path));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
      AppDialog.successDialog(
          context,
          "Successfully Account Create.",
          "Your account successfully created in our application.",
          "assets/lottie/success_lottie.json");
    }
  }
}
