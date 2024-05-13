import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';

@Entity()
class TaskModel {
  @Id(assignable: true)
  int id;
  String name;
  String description;
  Uint8List? fileData;


  TaskModel({
    this.id = 0,
    required this.name,
    this.description = "",
    this.fileData,
  });
}
