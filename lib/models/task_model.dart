class TaskModel {
  final String id;
  final String? description;
  final DateTime timeStart;
  final DateTime? timeEnd;
  final double? timeSummary;
  final String jobId;
  final String taskTypeId;
  final String userId;

  TaskModel({
    required this.id,
    this.description,
    required this.timeStart,
    required this.timeEnd,
    required this.timeSummary,
    required this.jobId,
    required this.taskTypeId,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'timeStart': timeStart.toIso8601String(),
      'timeEnd': timeEnd,
      'timeSummary': timeSummary,
      'jobId': jobId,
      'taskType': taskTypeId,
      'userId' : userId
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      description: map['description'] ?? '',
      timeStart: DateTime.parse(map['timeStart']),
      timeEnd: DateTime.parse(map['timeEnd']),
      timeSummary: map['timeSummary'],
      jobId: map['jobId'],
      taskTypeId: map['taskTypeId'],
      userId: map['userId'],
    );
  }
}