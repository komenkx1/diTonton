import 'package:flutter/foundation.dart';

class HomeNotifier extends ChangeNotifier {
  int _selectedScreen = 0;
  int get selectedScreen => _selectedScreen;

  changeSelectedNavBar(int index) {
    _selectedScreen = index;
    notifyListeners();
  }
}
