import 'package:flutter/material.dart';

class AppBottomNavigationProvider with ChangeNotifier {
  int currentIndex = 0;
  updateCurrentIndex(int index) {
    currentIndex = index;
  }
}