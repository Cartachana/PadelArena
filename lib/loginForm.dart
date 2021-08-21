import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './models/logged_user.dart';
import './logInButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_core/firebase_core.dart';

class LoginForm extends StatefulWidget {
  //LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //FirebaseAuth auth = FirebaseAuth.instance;
  final _form = GlobalKey<FormState>();

  var _loggedUser = LoggedUser(email: '', password: '');

  void _savedForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lime, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lime, width: 1.5),
                  ),
                  labelText: 'Email',
                  // errorText: 'Error Text',
                ),
                onSaved: (value) {
                  _loggedUser.email = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Obrigatorio';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lime, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lime, width: 1.5),
                  ),
                  labelText: 'Password',
                  // errorText: 'Error Text',
                ),
                onSaved: (value) {
                  _loggedUser.password = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Obrigatorio';
                  }
                  return null;
                },
              ),
            ),
            LogInButton(_savedForm),
          ]),
    );
  }
}
