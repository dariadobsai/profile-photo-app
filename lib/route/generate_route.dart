import 'package:flutter/material.dart';
import 'package:photo_app/route/route_names.dart';
import 'package:photo_app/ui/edit_page.dart';
import 'package:photo_app/ui/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
      case routeEdit:
        return MaterialPageRoute(
            builder: (_) => EditPhotoPage(
                  image: settings.arguments,
                ));
        break;
    }
  }
}
