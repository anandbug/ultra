import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultra/di/injectable.dart';
import 'package:ultra/bonds/presentation/screens/bonds_list_screen.dart';

void main() {
  configureDependencies();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
  );
  runApp(const UltraApp());
}

class UltraApp extends StatelessWidget {
  const UltraApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: const BondsListScreen());
}
