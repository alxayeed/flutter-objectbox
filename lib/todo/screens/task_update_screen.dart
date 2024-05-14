import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  Uint8List? fileData;

  @override
  void initState() {
    nameController.text = widget.task.name;
    descriptionController.text = widget.task.description;
    fileData = widget.task.fileData;
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
              if (fileData != null)
                Expanded(
                  child: Stack(alignment: Alignment.center, children: [
                    Image.memory(
                      fileData!,
                      height: 300,
                      width: 300,
                    ),
                    GestureDetector(
                      onLongPress: (){
                        setState(() {
                          fileData = null;
                        });
                      },
                      child: Container(
                        width: 60.0, // Adjust width and height as needed
                        height: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.7), // Adjust opacity here (0.0 to 1.0)
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white.withOpacity(0.7),
                          size: 50,
                        ),
                      ),
                    )
                  ]),
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
                        fileData = imageBytes;
                      });
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final Uint8List? imageBytes =
                          await FileManager.pickImageFromGallery();
                      setState(() {
                        fileData = imageBytes;
                      });
                    },
                    child: const Icon(Icons.image),
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  widget.task.fileData = fileData;
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
