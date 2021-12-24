import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/login/login_controller.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);

    return SafeArea(
      child: Container(
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //   image: NetworkImage('https://wallpaperaccess.com/full/1269989.jpg'),
        //   fit: BoxFit.cover,
        // )),
        child: Scaffold(
          // backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    'assets/chavez2.png',
                    height: 300.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                _userrTextField(context),
                const SizedBox(
                  height: 10.0,
                ),
                _passwordTextField(context),
                const SizedBox(
                  height: 20.0,
                ),
                _bottonLogin(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userrTextField(BuildContext context) {
    final controller = Provider.of<LoginController>(context);

    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            hintText: 'example@correo.com',
            labelText: 'Email',
            errorText: controller.usernameTextV!.error,
          ),
          onChanged: (String value){
            controller.usernameChanged(value);
          }
        ),
      );
    });
  }

  Widget _passwordTextField(BuildContext context) {
    final controller = Provider.of<LoginController>(context);

    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            hintText: 'Password',
            labelText: 'Password',
            errorText: controller.passwordTextV!.error,
          ),
          onChanged: (String value){
            controller.passwordChanged(value);
          }
        ),
      );
    });
  }

  Widget _bottonLogin(BuildContext context) {
    final controller = Provider.of<LoginController>(context);

    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text(
              'Sign In',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: () {
            (!controller.validate) ? null : Navigator.pushNamed(context, Routes.SPLASH);
          });
    });
  }
}