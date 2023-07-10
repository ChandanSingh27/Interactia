import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication_pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(onPressed: (){
          FirebaseAuth.instance.signOut();
          GoogleSignIn().signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
        }, icon: Icon(Icons.logout)),
      ),
    );
  }
}
