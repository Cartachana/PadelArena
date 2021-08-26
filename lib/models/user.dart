class Userr {
  static final Userr _user = Userr._internal();

  late String _id;
  late String _role;
  late String _name;
  late String _surname;
  late String _address;
  late String _city;
  late String _postCode;
  late String _nif;
  late String _email;

  factory Userr() => _user;

  String get id => _id;
  String get role => _role;
  String get name => _name;
  String get surname => _surname;
  String get address => _address;
  String get city => _city;
  String get postCode => _postCode;
  String get nif => _nif;
  String get email => _email;

  set id(String value) => _id = value;
  set role(String value) => _role = value;
  set name(String value) => _name = value;
  set surname(String value) => _surname = value;
  set address(String value) => _address = value;
  set city(String value) => _city = value;
  set postCode(String value) => _postCode = value;
  set nif(String value) => _nif = value;
  set email(String value) => _email = value;

  Userr._internal() {
    _id = '';
    _role = '';
    _name = '';
    _surname = '';
    _address = '';
    _city = '';
    _postCode = '';
    _nif = '';
    _email = '';
  }
}
