import 'package:cork_padel/models/ReservationStreamPublisher.dart';
import 'package:cork_padel/models/reservation.dart';
import 'package:cork_padel/models/user.dart';
import 'package:cork_padel/src/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'checkout.dart';

class ShoppingCart extends StatefulWidget {
  //String titleInput;
  //String amountInput;

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  Userr _user = Userr();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Column(
        children: [
          Text(
            'Carrinho',
            style: TextStyle(
              fontFamily: 'Roboto Condensed',
              fontSize: 26,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: StreamBuilder(
                  stream: ReservationStreamPublisher().getReservationStream(),
                  builder: (context, snapshot) {
                    final tilesList = <Card>[];
                    if (snapshot.hasData) {
                      List reservations = snapshot.data as List<Reservation>;
                      int i = 0;
                      do {
                        if (reservations.isNotEmpty) {
                          if (reservations[i].userEmail != _user.email) {
                            reservations.removeAt(i);
                            i = i;
                          } else
                            i++;
                        }
                      } while (i < reservations.length);
                      try {
                        tilesList.addAll(reservations.map((nextReservation) {
                          if (_user.email == nextReservation.userEmail &&
                              nextReservation.state == 'por completar') {
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Icon(Icons.watch),
                                title: Text('Dia ' + nextReservation.day),
                                subtitle: Text('Das ' +
                                    nextReservation.hour +
                                    ' as ' +
                                    nextReservation.duration),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _deleting(context, nextReservation.id);
                                  },
                                ),
                              ),
                            );
                          } else {
                            return Card();
                          }
                        }));
                      } catch (e) {
                        return Text('O carrinho esta vazio');
                      }
                    }
                    // }
                    if (tilesList.isNotEmpty) {
                      return Padding(
                        padding: EdgeInsets.all(0),
                        child: ListView(
                          children: tilesList,
                        ),
                      );
                    }
                    return Text('O carrinho esta vazio');
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontFamily: 'Roboto Condensed',
                  fontSize: 26,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  width: 150,
////////////////////// BUTTON TO RESERVE ////////////////////////////////////////////////
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        "Pagamento",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).push(
                          MaterialPageRoute(builder: (_) {
                            return Checkout();
                          }),
                        );
                      }))
            ],
          ),
        ],
      ),
    );
  }

  void _deleting(BuildContext context, String id) {
    final _database =
        FirebaseDatabase.instance.reference().child('reservations').child(id);
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Cancelar',
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Tem certeza de que quer cancelar esta reserva?',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Nao cancelar',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            StyledButton(
              onPressed: () {
                _database.remove();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Sim, Cancelar',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}
