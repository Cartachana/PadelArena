class Reservation {
  late String pin;
  late String day;
  late String hour;
  late String duration;
  late String state;
  late String userEmail;
  late bool completed;
  late String id;
  late String dateMade;
  late String timeMade;

  Reservation(
      {required this.pin,
      required this.day,
      required this.hour,
      required this.duration,
      required this.state,
      required this.userEmail,
      required this.completed,
      required this.id,
      required this.dateMade,
      required this.timeMade});

  factory Reservation.fromRTDB(Map<String, dynamic> data) {
    return Reservation(
        pin: data['pin'],
        day: data['day'],
        hour: data['hour'],
        duration: data['duration'],
        state: data['state'],
        userEmail: data['client_email'],
        completed: data['completed'],
        id: data['id'],
        dateMade: '',
        timeMade: '');
    //factory Reservation() => _reservation;
  }
}
