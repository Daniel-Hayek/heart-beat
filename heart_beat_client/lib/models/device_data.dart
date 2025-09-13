class DeviceData {
  final int id;
  final double sleepDuration;
  final double activityLevel;
  final double steps;
  final double heartrate;
  final int predictedStress;
  final DateTime createdAt;

  DeviceData({
    required this.id,
    required this.sleepDuration,
    required this.activityLevel,
    required this.steps,
    required this.heartrate,
    required this.predictedStress,
    required this.createdAt,
  });

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      id: json['id'] as int,
      sleepDuration: json['sleep_duration'] as double,
      activityLevel: json['activity_level'] as double,
      steps: json['steps'] as double,
      heartrate: json['heartrate'] as double,
      createdAt: DateTime.parse(json['created_at']),
      predictedStress: json['predicted_stress'] as int,
    );
  }
}
