import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/connectivity/connection_status_model.dart';
import 'package:google_maps_test/app/ui/pages/login/login_controller.dart';
import 'package:google_maps_test/app/ui/pages/routes/pages.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';
import 'package:google_maps_test/app/ui/pages/sign_in/sign_in_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignInController()
        ),
        ChangeNotifierProvider(
          create: (_) => LoginController()
        ),
        ChangeNotifierProvider(
          create: (_) => ConnectionStatusModel()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.SIGNIN,
        routes: appRoutes(),
      )
    );
  }
}
