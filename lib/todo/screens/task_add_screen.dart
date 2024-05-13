import 'package:flutter/material.dart';
import 'package:flutter_objectbox/objectbox.dart';
import 'package:flutter_objectbox/todo/model/task_model.dart';

class TaskAddScreen extends StatelessWidget {
  final ObjectBox objectBox;

  TaskAddScreen({
    super.key,
    required this.objectBox,
  });

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 400,
      child: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: descriptionController,
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: () {
              objectBox.addTask(
                TaskModel(
                  name: nameController.text,
                  description: descriptionController.text,
                ),
              );
              Navigator.pop(context);
            },
            color: Colors.blue,
            child: const SizedBox(
              child: Center(
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      // color: Colors.blue,
    );
  }
}
