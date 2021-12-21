import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
                _userrTextField(),
                const SizedBox(
                  height: 15.0,
                ),
                _passwordTextField(),
                const SizedBox(
                  height: 15.0,
                ),
                _bottonLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userrTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: const TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'example@correo.com',
            labelText: 'Email',
          ),
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: const TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Password',
            labelText: 'Password',
          ),
        ),
      );
    });
  }

  Widget _bottonLogin() {
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
            Navigator.pushNamed(context, Routes.SPLASH);
          });
    });
  }
}
