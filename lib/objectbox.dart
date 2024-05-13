import 'dart:async';

import 'package:flutter_objectbox/objectbox.g.dart';
import 'package:flutter_objectbox/todo/model/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ObjectBox {
  late final Store _store;
  late final Box<TaskModel> _taskBox;

  ObjectBox._create(this._store) {
    _taskBox = Box<TaskModel>(_store);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore(
        directory: p.join(
            (await getApplicationDocumentsDirectory()).path, "task_box"));

    return ObjectBox._create(store);
  }

  Future<void> addTask(TaskModel task) async {
    _taskBox.putAsync(task);
  }

  Stream<List<TaskModel>> getAllTask() {
    final builder = _taskBox.query().order(TaskModel_.name);

    StreamController<List<TaskModel>> controller = StreamController();

    controller.addStream(
        builder.watch(triggerImmediately: true).map((query) => query.find()));

    return controller.stream;
  }

  Future<void> removeTask(int id) async {
    _taskBox.removeAsync(id);
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    _taskBox.putAsync(updatedTask);
  }
}
