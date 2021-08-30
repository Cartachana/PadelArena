import 'dart:math';
import 'package:cork_padel/models/reservation.dart';
import 'package:cork_padel/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reserve extends StatefulWidget {
  @override
  _ReserveState createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  final database = FirebaseDatabase.instance.reference();
  Userr _user = Userr();
  String? _selectedDuration;

  DateTime? _selectedDate;
  TimeOfDay? _timeChosen;

  void _presentDatePicker() {
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
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
            context: context, initialTime: TimeOfDay(hour: 8, minute: 00))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _timeChosen = value;
      });
    });
  }

  num randomNumbers() {
    var rndnumber = "";
    var rnd = new Random();
    for (num i = 1; i < 10; i++) {
      rndnumber = rndnumber + (rnd.nextInt(9) + 1).toString();
    }
    num number = num.parse(rndnumber);
    return number;
  }

  void _reserve() async {
    num _id = randomNumbers();
    Reservation _reservation = Reservation();
    final reservations = database.child('reservations/');
    final day =
        reservations.child(DateFormat('ddMMyyyy').format(_selectedDate!));
    final time = day.child("${_timeChosen!.format(context)}");
    _reservation.id = _id.toString();
    _reservation.hour = _timeChosen!.format(context);
    _reservation.duration = _selectedDuration!;
    _reservation.state = 'open';
    _reservation.userEmail = _user.email;
    try {
      //await reservations.set(_reservation);
      await time.set({
        'id': _reservation.id,
        'hour': _reservation.hour,
        'duration': _reservation.duration,
        'state': 'open',
        'client_email': _user.email
      });
    } catch (e) {
      print('There is an error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Cork Padel Arena"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(10),
            width: double.infinity,
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
                          TextButton(
                            onPressed: _presentDatePicker,
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
                            child: Text(
                              _timeChosen == null
                                  ? 'Nenhuma hora escolhida!'
                                  : 'Hora Escolhida: ' +
                                      "${_timeChosen!.format(context)}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
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
                                width: 150,
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
                                        _selectedDuration = newValue;
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
                Container(
                  padding: EdgeInsets.all(15),
                  width: 150,
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
                      _reserve();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
