class FeedBackModel {
  final bool success;
  final int feedback;
  final DateTime date;

  FeedBackModel({
    this.success = false,
    required this.feedback,
    required this.date,
  });

  factory FeedBackModel.fromJson(Map<String, dynamic> json) {
    return FeedBackModel(
      feedback: json['feedback'],
      date: DateTime.parse(json['date']),
      success: json.isEmpty ? false : true,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feedback': feedback,
      'date': date.toIso8601String(),
    };
  }
}
