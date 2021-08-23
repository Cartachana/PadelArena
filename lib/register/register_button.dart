import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback selectHandler;

  RegisterButton(this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          onPrimary: Colors.white,
        ),
        child: Text(
          "Submeter",
          style: TextStyle(fontSize: 15),
        ),
        onPressed: selectHandler,
      ),
    );
  }
}
