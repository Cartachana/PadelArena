class checkoutValue {
  static final checkoutValue _check = checkoutValue._internal();

  late int _reservations;
  late int _price;

  factory checkoutValue() => _check;

  int get reservations => _reservations;
  int get price => _price;

  set reservations(int value) => _reservations = value;
  set price(int value) => _price = value;
  void moreReservations() => _reservations++;
  void lessReservations() => _reservations--;

  checkoutValue._internal() {
    _reservations = 0;
    _price = 0;
  }
}
