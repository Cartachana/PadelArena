import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cork_padel/main.dart';
import 'package:cork_padel/models/menuItem.dart';
import 'package:cork_padel/models/page.dart';
import 'package:cork_padel/register/user_details.dart';
import 'package:cork_padel/view/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/user.dart';
import './reserve.dart';
import 'contacts.dart';
import 'myReservations.dart';

enum UserDetailState {
  noDetails,
  notVerified,
  verified,
}

class Dash extends StatefulWidget {
  final Userr _userr = Userr();
  @override
  _DashState createState() => _DashState();

  Future<void> currentUser() {
    final user = FirebaseAuth.instance.currentUser;
    final String _email = user!.email.toString();
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_email)
        .get()
        .then((value) {
      _userr.name = value.data()!["first_name"].toString();
      _userr.email = value.data()!["email"].toString();
      _userr.address = value.data()!["address"].toString();
      _userr.surname = value.data()!["last_name"].toString();
      _userr.city = value.data()!["city"].toString();
      _userr.id = value.data()!["id"].toString();
      _userr.nif = value.data()!["nif"].toString();
      _userr.postCode = value.data()!["postal_code"].toString();
      _userr.role = value.data()!["role"].toString();
    });
  }
}

class _DashState extends State<Dash> {
  UserDetailState _userState = UserDetailState.verified;
  UserDetailState get loginState => _userState;

  @override
  void initState() {
    checkMore();
    super.initState();
  }

  Future<void> checkMore() async {
    await Firebase.initializeApp();

    final auth = FirebaseAuth.instance;
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        if (auth.currentUser!.emailVerified) {
          setState(() {
            _userState = UserDetailState.verified;
          });

          widget.currentUser();
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.email)
              .get()
              .then((onexist) {
            if (onexist.exists) {
              setState(() {
                _userState = UserDetailState.notVerified;
              });
            } else {
              setState(() {
                _userState = UserDetailState.noDetails;
              });
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_userState) {
      case UserDetailState.verified:
        return DashWidget();
      case UserDetailState.notVerified:
        return Verify();
      case UserDetailState.noDetails:
        return UserDetailsWidget();
      default:
        return Row(children: const [
          Text("Internal error, this shouldn't happen..."),
        ]);
    }
  }
}

class DashWidget extends StatefulWidget {
  @override
  DashWidgetState createState() => DashWidgetState();
}

class DashWidgetState extends State<DashWidget> {
  Userr _userr = Userr();
  var myName;
  Future<void>? _launched;

  var _url = 'https://www.corkpadel.pt/en/store';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void deleteOldReservations() {
    final reservations =
        FirebaseDatabase.instance.reference().child('reservations/');
    final DateTime today = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    reservations.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final reservation = Map<String, dynamic>.from(event.snapshot.value);
        reservation.forEach((key, value) {
          final String whenMade = value['dateMade'] + ' ' + value['timeMade'];
          final DateTime dbDay = formatter.parse(whenMade);

          if (today.isAfter(dbDay.add(Duration(minutes: 30))) &&
              value['state'] == 'por completar') {
            reservations.child(key).remove();
          }
        });
      }
    });
  }

  late Timer timer;
  @override
  void initState() {
    myName = _userr.name;
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      deleteOldReservations();
    });
    super.initState();
  }

  void setIt() {
    setState(() {
      _launched = _launchInBrowser(_url);
    });
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(5),
            width: double.infinity,
            height: 500,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Bem-Vindo ' + myName,
                    style: TextStyle(
                      fontFamily: 'Roboto Condensed',
                      fontSize: 26,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView(
                    padding: const EdgeInsets.all(5),
                    children: menus
                        .map((menus) => MenuItem(
                            menus.ikon, menus.title, menus.color, menus.fun))
                        .toList(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                  ),
                ),
                FutureBuilder<void>(future: _launched, builder: _launchStatus)
              ],
            )),
      ],
    );
  }

  var menus = [
    Pages(
      Icon(Icons.person, size: 50),
      'Perfil',
      Colors.lime,
      (BuildContext ctx) {
        Navigator.of(
          ctx,
        ).push(MaterialPageRoute(builder: (_) {
          return Profile();
        }));
      },
    ),
    Pages(
      Icon(Icons.calendar_today, size: 50),
      'Fazer Reserva',
      Colors.lime,
      (BuildContext ctx) {
        Navigator.of(
          ctx,
        ).push(MaterialPageRoute(builder: (_) {
          return Reserve();
        }));
      },
    ),
    Pages(
      Icon(Icons.perm_contact_calendar, size: 50),
      'Minhas Reservas',
      Colors.lime,
      (BuildContext ctx) {
        Navigator.of(
          ctx,
        ).push(MaterialPageRoute(builder: (_) {
          return MyReservations();
        }));
      },
    ),
    Pages(
        Icon(
          Icons.phone,
          size: 50,
        ),
        'Contactos',
        Colors.lime, (BuildContext ctx) {
      Navigator.of(
        ctx,
      ).push(MaterialPageRoute(builder: (_) {
        return Contacts();
      }));
    }),
    Pages(
      Icon(
        Icons.shopping_basket,
        size: 50,
      ),
      'Loja Online',
      Colors.lime,
      (BuildContext ctx) async {
        if (await canLaunch('https://www.corkpadel.pt/en/store')) {
          await launch(
            'https://www.corkpadel.pt/en/store',
            forceWebView: false,
            //headers: <String, String>{'my_header_key': 'my_header_value'},
          );
        } else {
          throw 'Could not launch the store';
        }
      },
    ),
    Pages(
        Icon(
          Icons.logout,
          size: 50,
        ),
        'Logout',
        Colors.lime, (BuildContext ctx) {
      FirebaseAuth.instance.signOut();
      Navigator.of(
        ctx,
      ).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return MyApp();
      }));
    })
  ];
}

class Verify extends StatefulWidget {
  late bool emailVerified;
  final _user = FirebaseAuth.instance.currentUser!;

  Future<void> checkEmailVerified() async {
    await _user.reload();
    if (_user.emailVerified) {
      emailVerified = true;
    } else {
      emailVerified = false;
    }
  }

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      widget.checkEmailVerified();
      if (widget._user.emailVerified) {
        timer.cancel();
        Navigator.of(context).pop();
      }
    });

    super.initState();
  }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Um email foi enviado para ${widget._user.email}. Por favor visite a sua caixa de email',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '\nNao recebeu o email de confirmacao?\n',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Container(
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    onPrimary: Colors.white,
                  ),
                  child: Text(
                    "Reenviar",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    widget._user.sendEmailVerification();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
