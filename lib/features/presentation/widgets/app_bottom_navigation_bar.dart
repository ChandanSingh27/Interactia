import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/app_bottom_navigation_provider.dart';

class AppBottomNavigationBar extends StatefulWidget {
  PageController screenController;
  AppBottomNavigationBar({super.key,required this.screenController});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppBottomNavigationProvider>(builder: (context, provider, child) => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: provider.currentIndex,
      onTap: (value) {
        provider.addTrackScreen(value);
        provider.updateCurrentIndex(value);
        provider.navigateDifferentScreens(widget.screenController);
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedIconTheme: IconThemeData(
        color: Colors.white.withOpacity(0.6),
        size: 24,
      ),
      selectedIconTheme: IconThemeData(
        color: Colors.white,
        size: 26,
      ),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: "Home"
        ),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search,),
            activeIcon: Icon(CupertinoIcons.search,),
            label: "search"
        ),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.plus,),
            label: "post"
        ),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.archivebox,),
            label: "post"
        ),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled,),
            label: "profile"
        ),
      ],
    ),);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.screenController.dispose();
  }
}
