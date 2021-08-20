import 'package:flutter/material.dart';

class RegisterPassword extends StatefulWidget {
  @override
  _RegisterPasswordState createState() => _RegisterPasswordState();
}

class _RegisterPasswordState extends State<RegisterPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Form(
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
        ),
      ),
    ));
  }
}
