import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'changeNotifiers/memory_details_notifier.dart';
import 'changeNotifiers/theme_change_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemoryDetailsNotifier()),
        ChangeNotifierProvider(create: (_) => ThemeChangeNotifier()),
      ],
      child: MyApp(),
    ),
  );
}
