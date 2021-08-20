import 'package:flutter/material.dart';

class RegisterCityPost extends StatefulWidget {
  @override
  _RegisterCityPostState createState() => _RegisterCityPostState();
}

class _RegisterCityPostState extends State<RegisterCityPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            //LOCALIDADE
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
                    labelText: 'Localidade',
                    // errorText: 'Error Text',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            //CODIGO POSTAL

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
                    labelText: 'Codigo Postal',
                    // errorText: 'Error Text',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
