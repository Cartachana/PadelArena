import 'package:cork_padel/models/ReservationStreamPublisher.dart';
import 'package:cork_padel/models/reservation.dart';
import 'package:cork_padel/models/user.dart';
import 'package:flutter/material.dart';

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
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: ReservationStreamPublisher().getReservationStream(),
                    builder: (context, snapshot) {
                      final tilesList = <ListTile>[];
                      if (snapshot.hasData) {
                        try {
                          final reservations =
                              snapshot.data as List<Reservation>;
                          tilesList.addAll(reservations.map((nextReservation) {
                            if (_user.email == nextReservation.userEmail &&
                                nextReservation.state == 'por completar') {
                              return ListTile(
                                  leading: Icon(Icons.lock_clock),
                                  title: Text('Das ' +
                                      nextReservation.hour +
                                      ' as ' +
                                      nextReservation.duration),
                                  subtitle: Text(nextReservation.state));
                            } else {
                              return ListTile();
                            }
                          }));
                        } catch (e) {
                          return Text('O carrinho esta vazio');
                        }
                      }
                      // }
                      if (tilesList.isNotEmpty) {
                        return Expanded(
                          child: ListView(
                            children: tilesList,
                          ),
                        );
                      }
                      return Text('');
                    })
                // child: ListView.builder(
                //     itemBuilder: (ctx, index) {
                //       return Card(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Text(
                //               'Data: ' + widget.days[index],
                //               style: Theme.of(context).textTheme.headline6,
                //             ),
                //             Text(
                //               'Das ' +
                //                   widget.tempRes[index].hour +
                //                   ' as ' +
                //                   widget.tempRes[index].duration,
                //               style: TextStyle(color: Colors.grey),
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //     itemCount: widget.tempRes.length),
                ),
          ),
        ],
      ),
    );
  }
}
