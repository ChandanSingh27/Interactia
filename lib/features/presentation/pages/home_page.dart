import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/app_bottom_navigation_provider.dart';
import 'package:taskhub/features/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:taskhub/utility/constants_color.dart';

import 'authentication_pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController screenController = PageController(initialPage: 0);
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
              child: Center(
                child: IconButton(onPressed: (){
                  FirebaseAuth.instance.signOut();
                  GoogleSignIn().signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                }, icon: Icon(Icons.logout)),
              ),
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
            ),Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.pink,
              child: Center(child: Text("Notification page"),),
            ),Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.amber,
              child: Center(child: Text("Profile page"),),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(screenController: screenController),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    screenController.dispose();
  }
}
