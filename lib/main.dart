import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/bloc/photo_bloc.dart';
import 'package:photo_app/route/generate_route.dart';
import 'package:photo_app/route/route_names.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhotoBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PhotoApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: routeHome,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
