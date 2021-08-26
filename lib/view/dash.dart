import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../../models/user.dart';
import './reserve.dart';

class Dash extends StatelessWidget {
  Userr _userr = Userr();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Cork Padel Arena"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 80.0,
                    height: 100.0,
                  ),
                ),
                Text(
                  'Ola ' + '${_userr.name}', ////////////////////
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 26,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Colors.white,
                    ),
                    child: const Text(
                      "Fazer Reserva",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) {
                        return Reserve();
                      }));
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                        ),
                        child: const Text(
                          "Logout",
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(
                            context,
                          ).push(MaterialPageRoute(builder: (_) {
                            return MyApp();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
