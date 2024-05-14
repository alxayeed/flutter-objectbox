import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_objectbox/objectbox.dart';
import 'package:flutter_objectbox/todo/model/task_model.dart';
import 'package:flutter_objectbox/todo/utility/file_manager.dart';

class TaskUpdateScreen extends StatefulWidget {
  final ObjectBox objectBox;
  final TaskModel task;

  const TaskUpdateScreen({
    super.key,
    required this.objectBox,
    required this.task,
  });

  @override
  State<TaskUpdateScreen> createState() => _TaskUpdateScreenState();
}

class _TaskUpdateScreenState extends State<TaskUpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.task.name;
    descriptionController.text = widget.task.description;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Update Task")),
      content: IntrinsicHeight(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              TextField(
                controller: nameController,
                onChanged: (value) {
                  widget.task.name = value;
                },
              ),
              TextField(
                controller: descriptionController,
                onChanged: (value) {
                  widget.task.description = value;
                },
              ),
              const SizedBox(height: 10),
              if (widget.task.fileData != null)
                Expanded(
                  child: Image.memory(
                    widget.task.fileData!,
                    height: 300,
                    width: 300,
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final Uint8List? imageBytes =
                      await FileManager.captureImageFromCamera();
                      setState(() {
                        widget.task.fileData = imageBytes;
                      });
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final Uint8List? imageBytes =
                      await FileManager.pickImageFromGallery();
                      setState(() {
                        widget.task.fileData = imageBytes;
                      });
                    },
                    child: const Icon(Icons.image),
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  widget.objectBox.updateTask(widget.task);
                  Navigator.pop(context);
                },
                color: Colors.green,
                child: const SizedBox(
                  child: Center(
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
