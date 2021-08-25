import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Dash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Cork Padel"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
            child: Row(
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
        )),
      ),
    );
  }
}
