import 'package:flutter/material.dart';
import 'package:flutter_objectbox/objectbox.dart';
import 'package:flutter_objectbox/todo/model/task_model.dart';
import 'package:flutter_objectbox/todo/screens/task_add_screen.dart';

class TaskListScreen extends StatelessWidget {
  final ObjectBox objectBox;
  const TaskListScreen({
    super.key,
    required this.objectBox,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "ObjectBox todo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: objectBox.getAllTask(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
              TaskModel task = snapshot.data![index];
              return GestureDetector(
                onLongPress: (){
                  objectBox.removeTask(task.id);
                },
                onTap: (){
                  task.name = "${task.name} is updated";
                  objectBox.updateTask(task);
                },
                child: ListTile(
                  title: Text(task.name),
                  subtitle: Text(task.description),
                ),
              );
            });
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text("Add Task")),
                  content: TaskAddScreen(objectBox: objectBox),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
