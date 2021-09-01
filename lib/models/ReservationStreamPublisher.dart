import 'package:cork_padel/models/reservation.dart';
import 'package:firebase_database/firebase_database.dart';

class ReservationStreamPublisher {
  final _database = FirebaseDatabase.instance.reference();

  Stream<List<Reservation>> getReservationStream() {
    final reservationStream = _database.child('reservations').onValue;
    final streamToPublish = reservationStream.map((event) {
      final reservationMap = Map<String, dynamic>.from(event.snapshot.value);
      final reservationList = reservationMap.entries.map((element) {
        return Reservation.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();
      return reservationList;
    });
    return streamToPublish;
  }
}
