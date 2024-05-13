import 'package:flutter/material.dart';
import 'package:flutter_objectbox/objectbox.dart';
import 'package:flutter_objectbox/todo/model/task_model.dart';
import 'package:flutter_objectbox/todo/screens/task_add_screen.dart';
import 'package:flutter_objectbox/todo/screens/task_update_screen.dart';

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
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 300,
                              width: double.infinity,
                              padding: const EdgeInsets.all(50),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(task.name),
                                  Text(task.description),
                                ],
                              ),
                            );
                          });
                    },
                    child: Dismissible(
                      key: Key(task.id.toString()),
                      background: Container(color: Colors.red),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        objectBox.removeTask(task.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${task.name} is deleted'),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(task.name),
                        subtitle: Text(task.description),
                        trailing: IconButton(
                          onPressed: () {
                            //TODO: update task
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Center(child: Text("Add Task")),
                                  content: TaskUpdateScreen(
                                    objectBox: objectBox,
                                    task: task,
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
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
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
