import 'package:flutter/material.dart';
import 'package:photo_app/route/generate_route.dart';
import 'package:photo_app/route/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhotoApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: routeHome,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
