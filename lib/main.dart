import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/login/login_controller.dart';
import 'package:google_maps_test/app/ui/pages/routes/pages.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';
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
          create: (_) => LoginController()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.LOGIN,
        routes: appRoutes(),
      )
    );
  }
}
