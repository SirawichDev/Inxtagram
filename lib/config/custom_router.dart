import 'package:bloc_medium_scale_project/screens/nav/nav_screen.dart';
import 'package:bloc_medium_scale_project/screens/screens.dart';
import 'package:bloc_medium_scale_project/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Router ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
      case SplashScreen.routeName:
        return SplashScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case NavScreen.routeName:
        return NavScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: const Center(
                child: Text(
                  'something went wrong..',
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                ),
              ),
            ));
  }
}
