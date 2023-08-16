import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/common/file_opreations.dart';
import 'package:taskhub/common/local_storage.dart';
import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';
import 'package:taskhub/features/domain/use_cases/user_register_use_case.dart';
import 'package:taskhub/features/presentation/manager/BottomNavigationBarProvider/profile_page_provider.dart';
import 'package:taskhub/features/presentation/manager/theme_provider.dart';
import 'package:taskhub/features/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/constants_text.dart';

import '../../../../locator.dart';
import '../../widgets/shimmer_effect_widget.dart';
import '../authentication_pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (kDebugMode) print("dispose method call");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      bool isDark = themeProvider.appThemeMode == ThemeMode.dark;
      return FutureBuilder(
        future: getIt
            .get<UserRegisterUseCase>()
            .fetchingUserDetails(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  snapshot.data!.username ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 20),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        LocalStorage.removeUserDetails();
                        FirebaseAuth.instance.signOut();
                        GoogleSignIn().signOut();
                        FileOperations.deleteFolder(folderName: "UserProfileDetails");
                        Get.offAll(() => const LoginPage());
                      },
                      icon: Icon(Icons.logout,
                          color: isDark ? Colors.white : Colors.black)),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(onPressed: (){
                    if(themeProvider.appThemeMode == ThemeMode.dark) {
                      themeProvider.setTheme(ThemeMode.light);
                    } else {
                      themeProvider.setTheme(ThemeMode.dark);
                    }
                  }, icon: Icon(isDark?Icons.sunny:CupertinoIcons.moon_stars,color: isDark?Colors.white:Colors.black,)),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              body: ListView(
                children: [
                  profileHeaderDetails(context, snapshot),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButton(
                          onTap: () {},
                          backgroundColor: AppConstantsColor.blueLight,
                          text: "Edit Profile",
                          disableButton: false,
                          loader: false)),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 1 - 300,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lottie/no_posts.json",
                            width: 200, height: 200, repeat: false),
                        const Text("No Posts"),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const ShimmerEffectWidget();
          }
        },
      );
    });
  }

  Widget profileHeaderDetails(
      BuildContext context, AsyncSnapshot<UserDetailsModel?> user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: CachedNetworkImage(
                imageUrl: user.data!.imageUrl.toString(),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 50,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/user_profile.png"),
                ),
                errorWidget: (context, url, error) => const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/user_profile.png"),
                ),
                // placeholder: (context, url) => ,
              ),
            ),
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("0"),
                        Text("Posts"),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(user.data?.follower?.length.toString() ?? "0"),
                        Text("Followers"),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(user.data?.following?.length.toString() ?? "0"),
                        const Text("Following"),
                      ],
                    ),
                  ],
                ))
          ],
        ),
        Flexible(
          child: Text(
            user.data?.fullName ?? "chandan",
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
