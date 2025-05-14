class HistoryModel {
  final bool success;
  final int id;
  final String history;
  final String message;
  final DateTime date;

  HistoryModel({
    this.success = false,
    required this.id,
    required this.history,
    required this.message,
    required this.date,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      history: json['history'],
      message: json['message'],
      date: DateTime.parse(json['date']),
      success: json.isEmpty ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'history': history,
      'message': message,
      'date': date.toIso8601String(),
    };
  }
}
