import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../../models/user.dart';
import './reserve.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class Dash extends StatelessWidget {
  Userr _userr = Userr();

  // void currentUser() {
  //   final String _email = _userr.email.toString();
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(_email)
  //       .get()
  //       .then((value) {
  //     _userr.name = value.data()!["first_name"].toString();
  //     _userr.address = value.data()!["address"].toString();
  //     _userr.surname = value.data()!["last_name"].toString();
  //     _userr.city = value.data()!["city"].toString();
  //     _userr.id = value.data()!["id"].toString();
  //     _userr.nif = value.data()!["nif"].toString();
  //     _userr.postCode = value.data()!["postal_code"].toString();
  //     _userr.role = value.data()!["role"].toString();
  //   });
  // }

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
