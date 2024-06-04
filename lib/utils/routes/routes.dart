import 'package:flutter/material.dart';
import 'package:pmob_project/utils/routes/routes_names.dart';
import 'package:pmob_project/view/admin/artikel_admin.dart';
import 'package:pmob_project/view/admin/jenisdaurulang_admin.dart';
import 'package:pmob_project/view/admin/penukaranpoin_admin.dart';
import 'package:pmob_project/view/splash_screen.dart';
import 'package:pmob_project/view/login_screen.dart';
import 'package:pmob_project/view/registrasi_screen.dart';
import 'package:pmob_project/view/users/dashboard_user.dart';
import 'package:pmob_project/view/admin/navbar_admin.dart';

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
      // ADMIN
      case (RouteNames.dashboardAdmin):
        return MaterialPageRoute(
            builder: (BuildContext context) => const NavbarAdmin());
      case (RouteNames.penukaranPoinAdmin):
        return MaterialPageRoute(
            builder: (BuildContext context) => const PenukaranPoinAdmin());
      case (RouteNames.artikelAdmin):
        return MaterialPageRoute(
            builder: (BuildContext context) => const ArtikelAdmin());
      case (RouteNames.jenisDaurUlangAdmin):
        return MaterialPageRoute(
            builder: (BuildContext context) => const JenisdaurulangAdmin());
      // USERS
      case (RouteNames.dashboardUser):
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashboardUser());

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
