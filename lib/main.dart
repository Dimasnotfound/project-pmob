import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pmob_project/utils/routes/routes.dart';
import 'package:pmob_project/utils/routes/routes_names.dart';
import 'package:pmob_project/viewmodel/akun_viewmodel.dart';
import 'package:pmob_project/viewmodel/login_viewmodel.dart';
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
