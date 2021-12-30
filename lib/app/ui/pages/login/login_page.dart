import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/login/login_controller.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';
import 'package:google_maps_test/app/ui/pages/widgets/global_alert.dart';
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
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    'assets/login.png',
                    height: 300.0,
                    width: 320.0,
                  ),
                ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                _userrTextField(context),
                const SizedBox(
                  height: 2.0,
                ),
                _passwordTextField(context),
                const SizedBox(
                  height: 15.0,
                ),
                _bottonLogin(context),
                _registerNow(context),
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
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          maxLength: 20,
          controller: controller.usernameController,
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
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          maxLength: 12,
          controller: controller.passwordController,
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

    return Consumer<LoginController>(
      builder: (context, model, child) => CupertinoButton(
        disabledColor: const Color(0XFF2196F3).withOpacity(0.7),
        pressedOpacity: 1,
        child: const Text('Log In'),
        color:
            model.validate ? const Color(0XFF2196F3) : const Color(0XFF2196F3).withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        onPressed: () {
          (!controller.validate) 
            ? showAlert(
                context, 
                msg: 'Incorrect username and/or password or empty field', 
                title: 'Important'
              )
            : Navigator.pushNamed(context, Routes.SPLASH);
        }
      )
    );
  }

  Widget _registerNow(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(Routes.SIGNIN),
            child: const Text('Register Now', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
          )
        ],
      ),
    );
  }
}

