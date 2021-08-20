import 'package:flutter/material.dart';

class RegisterNif extends StatefulWidget {
  @override
  _RegisterNifState createState() => _RegisterNifState();
}

class _RegisterNifState extends State<RegisterNif> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1.5),
              ),
              labelText: 'NIF',
              // errorText: 'Error Text',
            ),
          ),
        ),
      ),
    );
  }
}
