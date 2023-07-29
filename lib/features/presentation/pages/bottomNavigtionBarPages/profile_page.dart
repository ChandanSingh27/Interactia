import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:taskhub/common/local_storage.dart';
import 'package:taskhub/utility/constants_text.dart';

import '../authentication_pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  String? imageUrl;
  String? name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUsername();
  }

  setUsername() async {
    username = await LocalStorage.getKeyValue(
        key: SharePreferenceConstantText.username);
    imageUrl = await LocalStorage.getKeyValue(
        key: SharePreferenceConstantText.imageUrl);
    name =
        await LocalStorage.getKeyValue(key: SharePreferenceConstantText.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          username ?? "chandan",
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(onPressed: () {
            LocalStorage.removeUserDetails();
            FirebaseAuth.instance.signOut();
            GoogleSignIn().signOut();
            Get.offAll(()=>const LoginPage());
          }, icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                BoxIcons.bx_menu,
                size: 26,
              )),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: ListView(
        children: [
          profileHeaderDetails(context),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1 - 300,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottie/no_posts.json",width: 200,height: 200,repeat: false),
                Text("No Posts"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget profileHeaderDetails(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            (imageUrl != null)?
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imageUrl!),
              ): Container(
              width: 50,
              height: 50,
              child: Lottie.asset(AppConstantsText.profilePhotoLottie),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              name ?? "chandan",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        Column(
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
            Text("0"),
            Text("Followers"),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("0"),
            Text("Following"),
          ],
        ),
      ],
    );
  }
}
