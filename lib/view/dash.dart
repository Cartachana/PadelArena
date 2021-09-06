import 'package:cork_padel/models/menuItem.dart';
import 'package:cork_padel/models/page.dart';
import 'package:cork_padel/view/onlineShop.dart';
import 'package:cork_padel/view/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import './reserve.dart';
import 'contacts.dart';
import 'myReservations.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Cork Padel Arena"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 80.0,
              height: 100.0,
            ),
            DashWidget()
          ],
        ),
      ),
    );
  }
}

class DashWidget extends StatelessWidget {
  Userr _userr = Userr();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Ola ' + _userr.name,
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
          ],
        ));
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
    // Pages(
    //   Icon(Icons.perm_contact_calendar, size: 50),
    //   'Minhas Reservas',
    //   Colors.lime,
    //   (BuildContext ctx) {
    //     Navigator.of(
    //       ctx,
    //     ).push(MaterialPageRoute(builder: (_) {
    //       return MyReservations();
    //     }));
    //   },
    // ),
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
      (BuildContext ctx) {
        Navigator.of(
          ctx,
        ).push(MaterialPageRoute(builder: (_) {
          return OnlineShop();
        }));
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
    })
  ];
}

// class DashWidget extends StatelessWidget {
//   Userr _userr = Userr();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.all(20),
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Ola ' + _userr.name,
//               style: TextStyle(
//                 fontFamily: 'Roboto Condensed',
//                 fontSize: 26,
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: Theme.of(context).primaryColor,
//                   onPrimary: Colors.white,
//                 ),
//                 child: const Text(
//                   "Reservas",
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 onPressed: () {
//                   Navigator.of(
//                     context,
//                   ).push(MaterialPageRoute(builder: (_) {
//                     return Reserve();
//                   }));
//                 },
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                       onPrimary: Colors.white,
//                     ),
//                     child: const Text(
//                       "Logout",
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     onPressed: () async {
//                       FirebaseAuth.instance.signOut();
//                       Navigator.of(
//                         context,
//                       ).push(MaterialPageRoute(builder: (_) {
//                         return MyApp();
//                       }));
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ));
//   }
// }
