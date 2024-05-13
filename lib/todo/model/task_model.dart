import 'package:objectbox/objectbox.dart';

@Entity()
class TaskModel {
  int id;
  String name;
  String description;

  TaskModel({
    this.id=0,
    required this.name,
    this.description = "",
  });
}
