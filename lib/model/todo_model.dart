class TodoModel {
  final int id;
  final String title;
  final String? description;
  final int? priority;
  final String? createdDate;
  final bool? isDone;
  bool isChecked;

  TodoModel(
    this.id,
    this.title,
    this.description,
    this.priority,
    this.createdDate,
    this.isDone,
    this.isChecked,
  );
}
