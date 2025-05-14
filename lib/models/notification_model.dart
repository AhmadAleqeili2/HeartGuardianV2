class NotificationModel {
  final int id;
  final String message;
  final DateTime date;
  final bool success;

  NotificationModel({
    required this.id,
    required this.message,
    required this.date,
    this.success = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      message: json['message'],
      date: DateTime.parse(json['date']),
      success: json.isEmpty ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'date': date.toIso8601String(),
    };
  }
}
