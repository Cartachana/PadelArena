import 'dart:async';
import 'dart:math';
import 'package:cork_padel/models/ReservationStreamPublisher.dart';
import 'package:cork_padel/models/reservation.dart';
import 'package:cork_padel/models/user.dart';
import 'package:cork_padel/view/shoppingCart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class Reserve extends StatefulWidget {
  @override
  _ReserveState createState() => _ReserveState();
}

void showToast({
  required BuildContext context,
}) {
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(builder: (context) => ToastWidget());
  Overlay.of(context)!.insert(overlayEntry);
  Timer(Duration(seconds: 4), () => overlayEntry.remove());
}

class _ReserveState extends State<Reserve> {
  final database = FirebaseDatabase.instance.reference();

  Userr _user = Userr();
  String? _selectedDuration;
  String _warning = 'Nenhuma Hora Escolhida!';
  String _warning2 = '';

  DateTime? _selectedDate;
  TimeOfDay? _timeChosen;
  bool _reservationValid = false;
  bool _isNotNow = false;

  @override
  void initState() {
    super.initState();
  }

  void _activateListeners() {
    final reservations = database.child('reservations/');
    reservations.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final reservation = Map<String, dynamic>.from(event.snapshot.value);
        reservation.forEach((key, value) {
          String selectedDay = DateFormat('dd/MM/yyyy').format(_selectedDate!);
          String dbDay = value['day'];
          if (selectedDay == dbDay) {
            String maxTimeText = value['hour'];
            TimeOfDay _startTime = TimeOfDay(
                hour: int.parse(maxTimeText.split(":")[0]),
                minute: int.parse(maxTimeText.split(":")[1]));

            String minTimeText = value['duration'];
            TimeOfDay _endTime = TimeOfDay(
                hour: int.parse(minTimeText.split(":")[0]),
                minute: int.parse(minTimeText.split(":")[1]));

            TimeOfDay _until;
            _until = _timeChosen!.plusMinutes(int.parse(_selectedDuration!));

            double dbStartTime = toDouble(_startTime);
            double dbEndTime = toDouble(_endTime);
            double pickedStartTime = toDouble(_timeChosen!);
            double pickedEndTime = toDouble(_until);

            if (dbStartTime <= pickedStartTime &&
                dbEndTime >= pickedStartTime) {
              _reservationValid = false;
              _timeChosen = null;
              _warning = 'Ja existe uma reserva a essa hora!';
            } else if (dbStartTime <= pickedEndTime &&
                dbEndTime >= pickedEndTime) {
              _reservationValid = false;
              _timeChosen = null;
              _warning = 'Ja existe uma reserva a essa hora!';
            } else if (pickedStartTime <= dbStartTime &&
                dbEndTime <= pickedEndTime) {
              _reservationValid = false;
              _timeChosen = null;
              _warning = 'Ja existe uma reserva a essa hora!';
            } else {
              _reservationValid = true;
            }
          } else {
            _reservationValid = true;
          }
        });
      } else {
        _reservationValid = true;
      }
    });
  }

  void _presentDatePicker() {
    _reservationValid = false;
    showDatePicker(
            context: context,
            locale: const Locale("pt", "PT"),
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
        _timeChosen = null;
        _warning = 'Nenuma Hora Escolhida!';
      });
    });
  }

  void _presentTimePicker() {
    _reservationValid = false;
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 00),
    ).then((value) {
      if (value == null) {
        return;
      } else {
        var date = DateTime.now();
        if (_selectedDate != null) {
          var pickedTime = DateTime(_selectedDate!.year, _selectedDate!.month,
              _selectedDate!.day, value.hour, value.minute);
//COMPARING PICKED DATE WITH DATE NOW
          var comparison = pickedTime.compareTo(date);

// IF DATA CHOSEN IS AFTER NOW
          if (comparison == 1) {
            setState(() {
              _timeChosen = value;
              _isNotNow = true;
              _activateListeners();
            });
//IF DATE CHOSEN IS NOW OR BEFORE
          } else {
            setState(() {
              _timeChosen = null;
              _warning = 'Nao pode fazer reservas no passado';
              _isNotNow = true;
            });
          }
        } else {
//IF DAY IS NOT CHOSEN YET
          setState(() {
            _timeChosen = null;
            _warning = 'Escolha o Dia Primeiro';
          });
        }
      }
    });
  }

  num randomNumbers() {
    var rndnumber = "";
    var rnd = new Random();
    for (num i = 1; i < 7; i++) {
      rndnumber = rndnumber + (rnd.nextInt(9) + 1).toString();
    }
    num number = num.parse(rndnumber);
    return number;
  }

  void _showShoppingCart(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: ShoppingCart(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  var tempReservations = <Reservation>[];
  var days = <String>[];

  void _reserve() async {
    final reservations = database.child('reservations/');
    num _pin = randomNumbers();
    String _idd = DateFormat('ddMMyyyy').format(_selectedDate!) +
        "${_timeChosen!.format(context)}";

    final day = reservations.child(_idd);
    String until = _selectedDuration!;
    TimeOfDay _until;
    _until = _timeChosen!.plusMinutes(int.parse(_selectedDuration!));
    until = _until.format(context);

    Reservation _reservation = Reservation(
        pin: _pin.toString(),
        day: DateFormat('dd/MM/yyyy').format(_selectedDate!),
        hour: _timeChosen!.format(context),
        duration: until,
        state: 'por completar',
        userEmail: _user.email,
        completed: false,
        id: _idd);
    try {
      //await reservations.set(_reservation);
      await day.set({
        'id': _reservation.id,
        'day': _reservation.day,
        'hour': _reservation.hour,
        'duration': _reservation.duration,
        'state': _reservation.state,
        'client_email': _reservation.userEmail,
        'completed': _reservation.completed,
      });
    } catch (e) {
      print('There is an error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showShoppingCart(context);
        },
        child: Icon(Icons.shopping_cart),
      ),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Cork Padel Arena"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(10),
            constraints: BoxConstraints(
                minHeight: 600, minWidth: double.infinity, maxHeight: 680),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 80.0,
                    height: 100.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Efectuar Reserva',
                    style: TextStyle(
                      fontFamily: 'Roboto Condensed',
                      fontSize: 26,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.lime, width: 4),
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: <Widget>[
                          Expanded(
//TEXT SHOWING CHOSEN DATE////////////////////////////////////////////////
                            child: Text(
                              _selectedDate == null
                                  ? 'Nenhuma data escolhida!'
                                  : 'Data Escolhida: ' +
                                      DateFormat.yMd('pt')
                                          .format(_selectedDate!),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
//BUTTON TO CHOOSE DATE////////////////////////////////////////////////
                          TextButton(
                            onPressed: () {
                              _presentDatePicker();
                            },
                            child: Text("Escolher Data",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: <Widget>[
                          Expanded(
//TEXT SHOWING CHOSEN TIME ////////////////////////////////////////////////
                            child: Text(
                              _timeChosen == null
                                  ? _warning
                                  : 'Hora Escolhida: ' +
                                      "${_timeChosen!.format(context)}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
//BUTTON TO CHOOSE TIME ////////////////////////////////////////////////
                          TextButton(
                            onPressed: _presentTimePicker,
                            child: Text("Escolher Hora",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Duracao:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                width: 120,
//DROPDOWN LIST TO CHOOSE DURATION ////////////////////////////////////////////////
                                child: DropdownButton<String>(
                                  hint: Text('Escolha'),
                                  value: _selectedDuration,
                                  items: <String>['30', '60', '90', '120']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(
                                      () {
                                        if (_timeChosen != null) {
                                          _warning2 = '';
                                          _reservationValid = false;
                                          _selectedDuration = newValue;
                                          _activateListeners();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              Text(
                                'Minutos',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Text(_warning2),
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
                      "Reservar",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      print(_reservationValid);
                      print(_isNotNow);
                      _activateListeners();
                      if (_reservationValid &&
                          _isNotNow &&
                          _selectedDuration != null) {
                        _reserve();
                        showToast(context: context);
                      } else if (!_reservationValid || !_isNotNow) {
                        _timeChosen = null;
                        _warning = 'Slot invalido!';
                        setState(() {
                          _warning2 = 'Slot invalido!';
                        });
                      } else if (_selectedDuration == null) {
                        setState(() {
                          _warning2 = 'Escolha uma duracao';
                        });
                      }
                    },
                  ),
                ),
////////////////// LIST SHOWING RESERVES FOR THIS DAY ////////////////////////////////////////////////
                Text('Slots Reservados neste dia:'),
                _selectedDate != null
                    ? StreamBuilder(
                        stream:
                            ReservationStreamPublisher().getReservationStream(),
                        builder: (context, snapshot) {
                          final tilesList = <ListTile>[];
                          if (snapshot.hasData) {
                            List reservations =
                                snapshot.data as List<Reservation>;
                            int i = 0;
                            do {
                              if (reservations.isNotEmpty) {
                                if (reservations[i].day !=
                                    (DateFormat('dd/MM/yyyy')
                                        .format(_selectedDate!))) {
                                  reservations.removeAt(i);
                                  i = i;
                                } else
                                  i++;
                              }
                            } while (i < reservations.length);
                            try {
                              tilesList
                                  .addAll(reservations.map((nextReservation) {
                                return ListTile(
                                    leading: Icon(Icons.lock_clock),
                                    title: Text('Das ' +
                                        nextReservation.hour +
                                        ' as ' +
                                        nextReservation.duration),
                                    subtitle: Text(nextReservation.state));
                              }));
                            } catch (e) {
                              return Text(
                                  'Ainda nao existem reservas neste dia');
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
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  // Ported from org.threeten.bp;
  TimeOfDay plusMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      int mofd = this.hour * 60 + this.minute;
      int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

class ToastWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100.0,
      width: MediaQuery.of(context).size.width - 20,
      left: 10,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Material(
          color: Colors.lime,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'Reserva adicionada ao carrinho',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
