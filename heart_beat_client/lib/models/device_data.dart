class DeviceData {
  final int id;
  final double sleepDuration;
  final double activityLevel;
  final double steps;
  final double heartrate;
  final double phoneUsage;
  final int predictedStress;
  final DateTime createdAt;

  DeviceData({
    required this.id,
    required this.sleepDuration,
    required this.activityLevel,
    required this.steps,
    required this.heartrate,
    required this.phoneUsage,
    required this.predictedStress,
    required this.createdAt,
  });

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      id: json['id'] as int,
      sleepDuration: (json['sleep_duration'] as num).toDouble(),
      activityLevel: (json['activity_level'] as num).toDouble(),
      steps: (json['steps'] as num).toDouble(),
      heartrate: (json['heartrate'] as num).toDouble(),
      phoneUsage: (json['phone_usage'] as num).toDouble(),
      predictedStress: (json['predicted_stress'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
