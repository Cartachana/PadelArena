import 'package:flutter/cupertino.dart';

class User {
  String id;
  String name;
  String surname;
  String address;
  String city;
  String postCode;
  num nif;
  String email;
  String password;

  User(
      {@required this.id,
      @required this.name,
      @required this.surname,
      @required this.address,
      @required this.city,
      @required this.postCode,
      @required this.nif,
      @required this.email,
      @required this.password});
}
