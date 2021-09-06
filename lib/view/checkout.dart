import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: Text("Meu Perfil"),
          backgroundColor: Theme.of(context).primaryColor),
      body: Center(
        child: SingleChildScrollView(child: Column()),
      ),
    );
  }
}
