import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:flutter/services.dart';
import './loginForm.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'register/register_screen.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cork Padel',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Cork Padel"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: 80.0,
                  height: 100.0,
                ),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 26,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                LoginForm(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ou entrar com',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SignInButton(
                    Buttons.Facebook,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Ainda nao e cliente? Registe-se ',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextSpan(
                          text: 'aqui',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return RegisterScreen();
                              }));
                            }),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
