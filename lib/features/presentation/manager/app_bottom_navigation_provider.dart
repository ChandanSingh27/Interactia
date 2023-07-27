import 'package:flutter/material.dart';

class AppBottomNavigationProvider with ChangeNotifier {
  int currentIndex = 0;

  List<int> trackScreenList = [0];

  addTrackScreen(int screenIndex) {
    trackScreenList.add(screenIndex);
    notifyListeners();
  }
  navigateDifferentScreens(PageController pageController) {
    pageController.jumpToPage(currentIndex);
    notifyListeners();
  }

  removeTrackScreen(PageController pageController) {
    if(trackScreenList.isNotEmpty){
      trackScreenList.removeLast();
      currentIndex = trackScreenList.last;
      navigateDifferentScreens(pageController);
    }
    notifyListeners();
  }

  updateCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

}