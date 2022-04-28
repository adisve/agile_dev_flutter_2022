class TodoModel {
  final int id;
  final String title;
  final String? description;
  final int? priority;
  final String? deadline;
  final bool? isDone;
  bool isChecked;

  TodoModel(this.id, this.title, this.description, this.priority, this.deadline,
      this.isDone, this.isChecked);
}
