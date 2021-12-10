import 'package:fileshare/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ThemeChangeNotifier extends ChangeNotifier{

  ThemeData theme = ThemeConfig.darkTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }
  void setTheme(value) {
    theme = value;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeConfig.darkPrimary,
      statusBarIconBrightness: Brightness.light
    ));
    notifyListeners();
  }

  ThemeData getTheme(value) {
    return theme;
  }


}