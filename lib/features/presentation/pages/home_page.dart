import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/common/local_storage.dart';
import 'package:taskhub/features/presentation/manager/app_bottom_navigation_provider.dart';
import 'package:taskhub/features/presentation/pages/bottomNavigtionBarPages/home_page.dart';
import 'package:taskhub/features/presentation/pages/bottomNavigtionBarPages/profile_page.dart';
import 'package:taskhub/features/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:taskhub/utility/constants_color.dart';
import 'package:taskhub/utility/constants_text.dart';

import 'authentication_pages/login_page.dart';
import 'bottomNavigtionBarPages/notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    call();
    screenController = PageController(initialPage: 0);
  }
  call()async{
    username = await LocalStorage.getKeyValue(key: SharePreferenceConstantText.username);
    print("==================> $username <============================");
  }
  late PageController screenController ;
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<AppBottomNavigationProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        if(navigationProvider.trackScreenList.length == 1) {
          return true;
        }
        navigationProvider.removeTrackScreen(screenController);
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller: screenController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue,
              child: const BottomNavigationBarHomePage(),
            ),Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.red,
              child: Center(child: Text("Search page"),),
            ),Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.orange,
              child: Center(child: Text("Post page"),),
            ),SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: NotificationPage()
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ProfilePage(),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(screenController: screenController),
      ),
    );
  }

}
