class Reservation {
  late String id;
  late String day;
  late String hour;
  late String duration;
  late String state;
  late String userEmail;
  late bool completed;

  Reservation(
      {required this.id,
      required this.day,
      required this.hour,
      required this.duration,
      required this.state,
      required this.userEmail,
      required this.completed});

  factory Reservation.fromRTDB(Map<String, dynamic> data) {
    return Reservation(
        id: data['id'],
        day: data['day'],
        hour: data['hour'],
        duration: data['duration'],
        state: data['state'],
        userEmail: data['client_email'],
        completed: data['completed']);
    //factory Reservation() => _reservation;
  }
}
