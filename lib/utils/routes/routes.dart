import 'package:flutter/material.dart';
import 'package:trash_solver/utils/routes/routes_names.dart';
import 'package:trash_solver/view/admin/crud_artikel/artikel_admin.dart';
import 'package:trash_solver/view/admin/crud_artikel/edit_artikel.dart';
import 'package:trash_solver/view/admin/crud_artikel/tambah_artikel.dart';
import 'package:trash_solver/view/admin/crud_daurulang/edit_daurulang.dart';
import 'package:trash_solver/view/admin/crud_daurulang/tambah_daurulang.dart';
import 'package:trash_solver/view/admin/crud_daurulang/jenisdaurulang_admin.dart';
import 'package:trash_solver/view/admin/crud_jadwalpenjemputan/jadwalpenjemputan_admin.dart';
import 'package:trash_solver/view/admin/penukaranpoin_admin.dart';
import 'package:trash_solver/view/splash_screen.dart';
import 'package:trash_solver/view/login_screen.dart';
import 'package:trash_solver/view/registrasi_screen.dart';
import 'package:trash_solver/view/admin/navbar_admin.dart';
import 'package:trash_solver/view/users/artikel/detailArtikel.dart';
import 'package:trash_solver/view/users/jenis_sampah/detil_jenisSampah.dart';
import 'package:trash_solver/view/users/lokasi_daurulang/lokasi_daur_ulang.dart';
import 'package:trash_solver/view/users/navbar_user.dart';
import 'package:trash_solver/view/users/profil/profil.dart';

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
      case (RouteNames.tambahDaurUlangAdmin):
        return MaterialPageRoute(
            builder: (BuildContext context) => const TambahDaurulang());
      case (RouteNames.tambahArtikelAdmin):
        return MaterialPageRoute(
            builder: (BuildContext context) => const TambahArtikel());
      case (RouteNames.jadwalPenjemputanAdmin):
        return MaterialPageRoute(
            builder: (BuildContext context) => const JadwalpenjemputanAdmin());
      case RouteNames.editDaurUlangAdmin:
        final String id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => EditDaurulang(id: id),
        );
      case RouteNames.editArtikelAdmin:
        final String id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => EditArtikel(id: id),
        );

      // USERS
      case (RouteNames.dashboardUser):
        return MaterialPageRoute(
            builder: (BuildContext context) => const NavbarUser());
      case RouteNames.detilArtikel:
        final String id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => Detailartikel(id: id),
        );
      case RouteNames.detilSampah:
        final String id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (BuildContext context) => DetilJenisSampah(id: id),
        );
      case (RouteNames.lokasi):
        return MaterialPageRoute(
            builder: (BuildContext context) => const LokasiDaurUlang());
      case (RouteNames.profil):
        return MaterialPageRoute(
            builder: (BuildContext context) => const Profil());

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
