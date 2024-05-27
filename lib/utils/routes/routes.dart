import 'package:flutter/material.dart';
import 'package:pmob_project/utils/routes/routes_names.dart';
import 'package:pmob_project/view/splash_screen.dart';
import 'package:pmob_project/view/login_screen.dart';
import 'package:pmob_project/view/registrasi_screen.dart';
import 'package:pmob_project/view/dashboard_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.register):
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegistrasiScreen());
      case (RouteNames.login):
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case (RouteNames.splashScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case (RouteNames.dashboard):
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashboardScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}
