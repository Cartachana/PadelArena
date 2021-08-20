import 'package:flutter/material.dart';
import './register_name.dart';
import './register_citypost.dart';
import './register_address.dart';
import './register_nif.dart';
import './register_email.dart';
import './register_password.dart';
import './register_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void doNothing() {}
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
              margin: EdgeInsets.all(20),
              width: double.infinity,
              //height: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    width: 80.0,
                    height: 100.0,
                  ),
                  Text(
                    'REGISTO',
                    style: TextStyle(
                      fontFamily: 'Roboto Condensed',
                      fontSize: 26,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  RegisterName(),
                  //MORADA
                  RegisterAddress(),

                  RegisterCityPost(),
                  RegisterNif(),
                  RegisterEmail(),
                  RegisterPassword(),
                  RegisterButton(doNothing),
                ],
              ),
            ),
          ),
        ));
  }
}
