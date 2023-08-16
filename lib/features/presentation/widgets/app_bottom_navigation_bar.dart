import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/app_bottom_navigation_provider.dart';
import 'package:taskhub/features/presentation/manager/theme_provider.dart';

class AppBottomNavigationBar extends StatefulWidget {
  PageController screenController;
  AppBottomNavigationBar({super.key, required this.screenController});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppBottomNavigationProvider, ThemeProvider>(
      builder: (context, provider, themeProvider, child) {
        bool isDark = themeProvider.appThemeMode == ThemeMode.dark;
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          currentIndex: provider.currentIndex,
          onTap: (value) {
            provider.addTrackScreen(value);
            provider.updateCurrentIndex(value);
            provider.navigateDifferentScreens(widget.screenController);
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedIconTheme: IconThemeData(
            color: isDark
                ? Colors.white.withOpacity(0.6)
                : Colors.black.withOpacity(0.6),
            size: 28,
          ),
          selectedIconTheme: IconThemeData(
            color: isDark ? Colors.white : Colors.black,
            size: 28,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                activeIcon: Icon(CupertinoIcons.house_fill),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(BoxIcons.bx_search),
                activeIcon: Icon(
                  BoxIcons.bxs_search,
                ),
                label: "search"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.plus_app,
                ),
                activeIcon: Icon(
                  CupertinoIcons.plus_app_fill,
                ),
                label: "post"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.bell,
                ),
                activeIcon: Icon(CupertinoIcons.bell_fill),
                label: "post"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.profile_circled,
                ),
                activeIcon: Icon(BoxIcons.bxs_user_circle),
                label: "profile"),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.screenController.dispose();
  }
}
