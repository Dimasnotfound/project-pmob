import 'package:flutter/material.dart';
import 'package:trash_solver/viewmodel/editartikel_viewmodel.dart';
import 'package:trash_solver/viewmodel/editdaurulang_viewmodel.dart';
import 'package:trash_solver/viewmodel/jadwalpenjemputan_viewmodel.dart';
import 'package:trash_solver/viewmodel/tambahartikel_viewmodel.dart';
import 'package:trash_solver/viewmodel/tambahdaurulang_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:trash_solver/utils/routes/routes.dart';
import 'package:trash_solver/utils/routes/routes_names.dart';
import 'package:trash_solver/viewmodel/akun_viewmodel.dart';
import 'package:trash_solver/viewmodel/login_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AkunViewModel()),
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => TambahDaurulangViewModel()),
          ChangeNotifierProvider(create: (_) => EditDaurulangViewModel()),
          ChangeNotifierProvider(create: (_) => EditartikelViewmodel()),
          ChangeNotifierProvider(create: (_) => TambahartikelViewmodel()),
          ChangeNotifierProvider(create: (_) => JadwalpenjemputanViewmodel()),
        ],
        child: MaterialApp(
          title: 'Trash Solver',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: Routes.generateRoutes,
        ));
  }
}
