class ReservationRequest {
  final int resortId;
  final String lessonType; // SKI or BOARD
  final int totalStudent;
  final String lessonDate;
  final String startTime;
  final int duration;
  final int cost;

  ReservationRequest({
    required this.resortId,
    required this.lessonType,
    required this.totalStudent,
    required this.lessonDate,
    required this.startTime,
    required this.duration,
    required this.cost,
  });
}

class Reservation {}
