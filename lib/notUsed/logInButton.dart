import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {
  final VoidCallback selectHandler;

  LogInButton(this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          onPrimary: Colors.white,
        ),
        child: Text(
          "Entrar",
          style: TextStyle(fontSize: 15),
        ),
        onPressed: selectHandler,
      ),
    );
  }
}
