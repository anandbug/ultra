import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultra/di/injectable.dart';
import 'package:ultra/router/app_router.dart';

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
  Widget build(BuildContext context) => MaterialApp.router(
    routeInformationProvider: AppRouter.router.routeInformationProvider,
    routeInformationParser: AppRouter.router.routeInformationParser,
    routerDelegate: AppRouter.router.routerDelegate,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
    ),
  );
}
