import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';
import 'package:google_maps_test/app/ui/pages/sign_in/sign_in_controller.dart';
import 'package:google_maps_test/app/ui/pages/widgets/global_alert.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({ Key? key }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final LocalAuthentication _autenticacion = LocalAuthentication();
  bool _podemosUsarAutorizacion = false;
  String _autorizado = "No autorizado";


  /// Biometría
  Future<void> _autorizar() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _autenticacion.authenticateWithBiometrics(
        localizedReason: "Autentíquese para completar su transacción",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _autorizado = "Autorizado";
      } else {
        _autorizado = "No autorizado";
      }
      print("Autorizado? $_autorizado");
    });
  }


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
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  'assets/sign_in.png',
                  height: 300.0,
                  width: 320.0,
                ),
              ),
              // const SizedBox(
              //   height: 10.0,
              // ),
              // _emailTextField(context),
              _userTextField(context),
              // const SizedBox(
              //   height: 2.0,
              // ),
              _passwordTextField(context),
              const SizedBox(
                height: 10.0,
              ),
              _bottonLogin(context),
              _registered(context),
              _termsAndPolicy(context),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Estado: $_autorizado \n'),
                  CupertinoButton(
                    child: const Text('verificación'),
                    onPressed: _autorizar,
                  )
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _emailTextField(BuildContext context) {
  Widget _userTextField(BuildContext context) {
    final controller = Provider.of<SignInController>(context);

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
            hintText: 'Holamundo1',
            labelText: 'Username',
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
    final controller = Provider.of<SignInController>(context);

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
    final controller = Provider.of<SignInController>(context);

    return Consumer<SignInController>(
      builder: (context, model, child) => CupertinoButton(
        disabledColor: const Color(0XFF2196F3).withOpacity(0.7),
        pressedOpacity: 1,
        child: const Text('Sign In'),
        color:
            model.validate ? const Color(0XFF2196F3) : const Color(0XFF2196F3).withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        onPressed: () {
          (!controller.validate) 
            ? showAlert(
                context, 
                msg: 'Incorrect email and/or username and/or password or empty field', 
                title: 'Important'
              )
            : Navigator.pushNamed(context, Routes.SPLASH);
        }
      )
    );
  }

  Widget _termsAndPolicy(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('To use this app you need to agree to our '),
          GestureDetector(
            onTap: (){
              showAlert(
                context, 
                msg: 'This service is provided AS IS and has no current warranty on how the \ndata and uptime is managed. The final terms will be released when the final version of the app \nwill be released.', 
                title: 'Terms of Service'
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Terms of Service', style: TextStyle(fontWeight: FontWeight.bold),),
                const Text(' and '),
                GestureDetector(
                  onTap: (){
                    showAlert(
                      context, 
                      msg: 'All your data is saved anonymously on Firebase Firestore database and will be remain that way. \nNo other users will have access to it.', 
                      title: 'Privacy Policy'
                    );
                  },
                  child: const Text('Privacy Policy', style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            )
          ),
        ],
      )
    );
  }

  Widget _registered(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already registeded? '),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(Routes.LOGIN),
            child: const Text('Log In', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
          )
        ],
      ),
    );
  }
}

