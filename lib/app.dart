import 'dart:io';

import 'package:fileshare/ui/splash_screen.dart';
import 'package:fileshare/utils/theme_config.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'changeNotifiers/theme_change_notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeNotifier>(
      builder: (BuildContext context, appProvider, Widget? child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: "FileShare",
          theme: appProvider.theme,
          darkTheme: ThemeConfig.darkTheme,
          home:SplashScreen(),
        );
      },
    );
  }
}
