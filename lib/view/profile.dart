import 'package:cork_padel/models/user.dart';
import 'package:flutter/material.dart';
import 'editDetails.dart';
import 'myReservations.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  Userr _userr = Userr();
  static const double _padd = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: Text("Meu Perfil"),
          backgroundColor: Theme.of(context).primaryColor),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
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
              'Meu Perfil',
              style: TextStyle(
                fontFamily: 'Roboto Condensed',
                fontSize: 26,
                color: Colors.lime,
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 15, top: 50, right: 15, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Nome: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        _userr.name + ' ' + _userr.surname,
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: _padd),
                    child: Row(children: [
                      Text(
                        "Email: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        _userr.email,
                        style: TextStyle(fontSize: 16),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: _padd),
                    child: Row(
                      children: [
                        Text(
                          "Morada: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Container(
                          child: Text(
                            _userr.address,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: _padd),
                    child: Row(children: [
                      Text(
                        "Codigo Postal: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        _userr.postCode,
                        style: TextStyle(fontSize: 16),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: _padd),
                    child: Row(children: [
                      Text(
                        "Localidade: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        _userr.city,
                        style: TextStyle(fontSize: 16),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: _padd),
                    child: Row(children: [
                      Text(
                        "NIF: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        _userr.nif,
                        style: TextStyle(fontSize: 16),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        "Editar Perfil",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (_) {
                          return EditDetails();
                        }));
                      },
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        "Minhas Reservas",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (_) {
                          return MyReservations();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
