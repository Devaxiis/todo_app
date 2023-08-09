import 'package:flutter/material.dart';
import 'package:todo_app/core/service_locator.dart';

import 'package:todo_app/presentation/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: mode,
        child: const Home(),
        builder: (_, mode, child) {
          return MaterialApp(
            themeMode: mode,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            debugShowCheckedModeBanner: false,
            home: child,
          );
        });
  }
}
