import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/post_page_provider.dart';
import 'package:taskhub/features/presentation/manager/theme_provider.dart';
import 'package:taskhub/utility/constants_text.dart';
import '../../../../utility/constants_color.dart';
import '../../../../utility/constants_text_style.dart';
import '../../../../utility/constants_value.dart';
import '../../widgets/custom_buttons/custom_button.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {

  TextEditingController photoCaptions = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PostPageProvider>(context,listen: false).getImageFromInternalStorageCamera();
  }

  @override
  bool get wantKeepAlive => true;
  TextEditingController postThoughtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "New post",
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
          ),
          actions: [TextButton(onPressed: () {}, child: const Text("share"))],
        ),
        body: Consumer2<PostPageProvider,ThemeProvider>(
          builder: (context, postProvider, themeProvider, child) {
            bool isDark = themeProvider.appThemeMode == ThemeMode.dark;
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: postProvider.postImage!=null?Image.file(File(postProvider.postImage!),fit: BoxFit.contain,):Lottie.asset(AppConstantsText.profilePhotoLottie),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Camera Photos",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),),
                      Expanded(
                        child: Container(
                          color: isDark ? AppConstantsColor.matteBlack : AppConstantsColor.white,
                          child: postProvider.images.isNotEmpty ? GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                            itemCount: postProvider.images.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  postProvider.setPostImage(postProvider.images[index]);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  margin: const EdgeInsets.all(2),
                                  height: 300,
                                  width: 300,
                                  child: Image.file(File(postProvider.images[index]),fit: BoxFit.cover,),
                                ),
                              );
                            },
                          ): const Center(child: Text("No Image Found. Please use Add button to upload your photos...",textAlign: TextAlign.center,)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
        floatingActionButton: Consumer<PostPageProvider>(
          builder: (context, postProvider, child) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () => photoCaptionsDialog(),
                backgroundColor: AppConstantsColor.blueLight,
                child: const Icon(CupertinoIcons.captions_bubble_fill,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5,),
              FloatingActionButton(
                onPressed: () => postImageSourceDialog(isDark),
                backgroundColor: AppConstantsColor.blueLight,
                child: const Icon(CupertinoIcons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }

  postImageSourceDialog(bool isDark) {
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
                  selectPostImage(ImageSource.camera, isDark);
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
                  selectPostImage(ImageSource.gallery, isDark);
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

  selectPostImage(ImageSource source, bool isDark) async {
    try {
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
            Provider.of<PostPageProvider>(context,listen: false).setPostImage(croppedFile.path);
      }
    } catch (error) {
      if (kDebugMode) {
        print("image cropper error : $error");
      }
    }
  }

  photoCaptionsDialog() {
    return SmartDialog.show(builder: (context) {
      return Consumer2<ThemeProvider,PostPageProvider>(
        builder: (context, themeProvider, postProvider, child) {
          bool isDark = themeProvider.appThemeMode == ThemeMode.dark;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09),
            decoration: BoxDecoration(
              color: isDark ? AppConstantsColor.matteBlack : AppConstantsColor.darkWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Photo Captions",style: Theme.of(context).textTheme.bodyMedium,),
                  const SizedBox(height: 10,),
                  if(postProvider.postImage != null) Image.file(File(postProvider.postImage!),width: 100,height: 100,),
                  Container(
                    color: Colors.transparent,
                    height: 80,
                    child: TextField(
                      style: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
                      controller: photoCaptions,
                      maxLines: null,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        hintText: "write a captions...",
                      ),
                    ),
                  ),
                  Divider(color: AppConstantsColor.appTextLightShadeColor.withOpacity(0.7),),
                  InkWell(onTap: (){SmartDialog.dismiss();},child: Container(margin: const EdgeInsets.only(top: 5),alignment: Alignment.center,child: Text(AppConstantsText.done,style: TextStyle(color: AppConstantsColor.blueLight),),),),
                ],
              ),
            ),
          );
        }
      );
    });
  }

}
