import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Router ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),);
      default:
        return _errorRoute();
    }
  }
  static Route _errorRoute() {
    return MaterialPageRoute( settings: const RouteSettings(name: '/error'),builder: (_) => Scaffold(
      appBar: AppBar(
        title:  const Text('Error')
      ),
      body: const Center(child: Text('something went wrong..',style: TextStyle(
        fontSize: 20.0,
        color: Colors.red
      ),),),
    ));
  }
}