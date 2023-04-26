
import 'package:appeal/model/appeal.dart';
import 'package:flutter/cupertino.dart';

import 'data/database_helper.dart';

class MainProvider extends ChangeNotifier{

  bool isDark = false;

  void changeTheme(){
    isDark = !isDark;
    notifyListeners();
  }

  bool getThemeColor() {
  return isDark;
  }
  void updateAppealList() {
    notifyListeners();
  }

  void langChanged () {
    notifyListeners();
  }

}