class JobModel {
  final String title;
  final String? jobUrl;
  final String id;
  final String clientId;
  final int jobNumber;

  JobModel({
    required this.title,
    this.jobUrl,
    required this.id,
    required this.clientId,
    required this.jobNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'jobUrl': jobUrl,
      'id': id,
      'clientId': clientId,
      'jobNumber': jobNumber,
    };
  }

  factory JobModel.fromJson(Map<String, dynamic> map) {
    return JobModel(
      title: map['title'],
      jobUrl: map['jobUrl'],
      id: map['id'],
      clientId: map['clientId'],
      jobNumber: map['jobNumber'] as int,
    );
  }
}
