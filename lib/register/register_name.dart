import 'package:flutter/material.dart';

class RegisterName extends StatefulWidget {
  @override
  _RegisterNameState createState() => _RegisterNameState();
}

class _RegisterNameState extends State<RegisterName> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //PRIMEIRO NOME
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  child: TextFormField(
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
                      labelText: 'Nome',
                      // errorText: 'Error Text',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              //ULTIMO NOME
              //padding: EdgeInsets.all(10.0),

              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  child: TextFormField(
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
                      labelText: 'Sobrenome',
                      // errorText: 'Error Text',
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
