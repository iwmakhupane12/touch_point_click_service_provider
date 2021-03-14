import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/screens/splashScreen.dart';

void main() {
  runApp(MyServiceProviderApp());
}

class MyServiceProviderApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TPClick Service Provider',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
