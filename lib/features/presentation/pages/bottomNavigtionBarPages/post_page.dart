import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/post_page_provider.dart';
import 'package:taskhub/utility/constants_text.dart';
import '../../../../utility/constants_color.dart';
import '../../../../utility/constants_value.dart';
import '../../widgets/custom_buttons/custom_button.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  TextEditingController postThoughtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<PostPageProvider>(context, listen: false).getImageFromInternalStorageCamera();
  }

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
          actions: [TextButton(onPressed: () {}, child: const Text("Next"))],
        ),
        body: Consumer<PostPageProvider>(
          builder: (context, postProvider, child) {
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
                      child: postProvider.postImage!=null?Image.file(postProvider.postImage!,fit: BoxFit.contain,):Lottie.asset(AppConstantsText.profilePhotoLottie),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: AppConstantsColor.matteBlack,
                    child: GridView.builder(
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
                            margin: const EdgeInsets.all(2),
                            height: 300,
                            width: 300,
                            child: Image.file(postProvider.images[index],fit: BoxFit.cover,),
                          ),
                        );
                      },
                    )
                  ),
                ),
              ],
            );
          }
        ),
        floatingActionButton: Consumer<PostPageProvider>(
          builder: (context, postProvider, child) => FloatingActionButton(
            onPressed: postProvider.postImage != null
                ? () => postProvider.unsetPostImage()
                : () => postImageSourceDialog(isDark),
            backgroundColor: AppConstantsColor.blueLight,
            child: Icon(
              postProvider.postImage != null
                  ? CupertinoIcons.arrow_up
                  : CupertinoIcons.add,
              color: Colors.white,
            ),
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
            // context.watch<PostPageProvider>().setPostImage(Image(image: File(croppedFile.path) as ImageProvider,) as LocalImage);
      }
    } catch (error) {
      if (kDebugMode) {
        print("image cropper error : $error");
      }
    }
  }

  /*
  * body: Column(
        children: [
          Expanded(
            flex: 4,
              child: GestureDetector(
                onTap: () => postImageSourceDialog(isDark),
                child: Consumer<PostPageProvider>(
                  builder: (context, postProvider, child) {
                    return postProvider.postImage != null ? SizedBox(
                      child: InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 4.0,
                          child: Image.file(postProvider.postImage!,fit: BoxFit.cover,)),
                    ) : SizedBox(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset(AppConstantsText.uploadImageLottie),
                              const Text("Click to browser image")
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ),
          Expanded(
            flex: 1,
              child: Container(
                padding: EdgeInsets.all(AppConstants.constantsAppPadding),
                width: double.infinity,
                height: double.infinity,
                color: AppConstantsColor.matteBlack,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("say something about this photo...",style: Theme.of(context).textTheme.bodySmall,),
                      const SizedBox(height: 10,),
                      TextField(
                        controller: postThoughtController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: "Type here"
                        ),
                        style: isDark ? AppConstantTextStyle.formFieldTextStyleWhite() : AppConstantTextStyle.formFieldTextStyleBlack(),
                      ),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
      ,*/
}
