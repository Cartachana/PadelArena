import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:flutter/services.dart';
import './loginForm.dart';
import './logInButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cork Padel',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  void doNothing() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cork Padel"),
        backgroundColor: Colors.lime,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          width: 300,
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
                  color: Colors.lime,
                ),
              ),
              loginForm(),
              LogInButton(doNothing),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ou entrar com',
                  style: TextStyle(
                    color: Colors.lime,
                    fontSize: 15,
                  ),
                ),
              ),
              SignInButton(
                Buttons.Facebook,
                onPressed: () {},
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ainda nao e cliente? Registe-se aqui',
                  style: TextStyle(
                    color: Colors.lime,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
