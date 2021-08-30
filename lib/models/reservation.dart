class Reservation {
  static final Reservation _reservation = Reservation._internal();

  late String _id;
  late String _hour;
  late String _duration;
  late String _state;
  late String _userEmail;
  late bool _completed;

  factory Reservation() => _reservation;

  String get id => _id;
  String get hour => _hour;
  String get duration => _duration;
  String get state => _state;
  String get userEmail => _userEmail;
  bool get completed => _completed;

  set id(String value) => _id = value;
  set hour(String value) => _hour = value;
  set duration(String value) => _duration = value;
  set state(String value) => _state = value;
  set userEmail(String value) => _userEmail = value;
  set completed(bool value) => _completed = value;

  Reservation._internal() {
    _id = '';
    _hour = '';
    _duration = '';
    _state = '';
    _userEmail = '';
    _completed = false;
  }
}
