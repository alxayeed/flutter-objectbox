import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_objectbox/objectbox.dart';
import 'package:flutter_objectbox/todo/model/task_model.dart';
import 'package:flutter_objectbox/todo/utility/file_manager.dart';

class TaskAddScreen extends StatefulWidget {
  final ObjectBox objectBox;

  const TaskAddScreen({
    super.key,
    required this.objectBox,
  });

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Uint8List? _fileData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Add Task")),
      content: IntrinsicHeight(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 10),
              if (_fileData != null)
                Image.memory(
                  _fileData!,
                  height: 100,
                  width: 100,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final Uint8List? imageBytes = await FileManager.captureImageFromCamera();
                      setState(() {
                        _fileData = imageBytes;
                      });
                    },
                    child: const Text('Capture Image'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final Uint8List? imageBytes = await FileManager.pickImageFromGallery();
                      setState(() {
                        _fileData = imageBytes;
                      });
                    },
                    child: const Text('Upload from Gallery'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MaterialButton(
                onPressed: () {
                  widget.objectBox.addTask(
                    TaskModel(
                      name: nameController.text,
                      description: descriptionController.text,
                      fileData: _fileData,
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
        ),
      ),
    );
  }
}
