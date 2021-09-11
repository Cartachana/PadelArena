import 'package:flutter/material.dart';

class ProfileUpdatedSplash extends StatefulWidget {
  @override
  _ProfileUpdatedSplashState createState() => _ProfileUpdatedSplashState();
}

class _ProfileUpdatedSplashState extends State<ProfileUpdatedSplash> {
  @override
  void initState() {
    super.initState();
    _goToDash();
  }

  _goToDash() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(20),
            width: double.infinity,
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
                  'Perfil actualizado com sucesso',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 26,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Image.asset(
                  'assets/images/check.png',
                  width: 80.0,
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
