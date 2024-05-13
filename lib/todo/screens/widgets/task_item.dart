import 'package:flutter/material.dart';

import '../../../objectbox.dart';
import '../../model/task_model.dart';
import '../task_update_screen.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.objectBox,
  });

  final TaskModel task;
  final ObjectBox objectBox;

  @override
  Widget build(BuildContext context) {
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
          leading: task.fileData != null
              ? Image.memory(
                  task.fileData!,
                  width: 50,
                  height: 50,
                )
              : const SizedBox(
                  height: 50,
                  width: 50,
                ),
          title: Text(task.name),
          subtitle: Text(task.description),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TaskUpdateScreen(
                    objectBox: objectBox,
                    task: task,
                  );
                },
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
