import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier{
  int selectedIndex = 0;
  String lang ="ar";

  void onItemTapped(int index){
    selectedIndex= index;
    notifyListeners();
  }
}