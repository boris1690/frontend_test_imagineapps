class Task {
  final int id;
  final String title;
  final String description;
  final String status;

  Task(
    this.id,
    this.title,
    this.description,
    this.status,
  );

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        status = json['status'];
}
