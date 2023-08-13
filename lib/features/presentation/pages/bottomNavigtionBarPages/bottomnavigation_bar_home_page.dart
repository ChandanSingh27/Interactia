import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:taskhub/utility/constants_text.dart';

class BottomNavigationBarHomePage extends StatefulWidget {
  const BottomNavigationBarHomePage({super.key});

  @override
  State<BottomNavigationBarHomePage> createState() => _BottomNavigationBarHomePageState();
}

class _BottomNavigationBarHomePageState extends State<BottomNavigationBarHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstantsText.appName,style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.chat_bubble_text_fill))
        ],
      ),
    );
  }
}
