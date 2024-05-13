import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_objectbox/objectbox.dart';
import 'package:flutter_objectbox/todo/model/task_model.dart';
import 'package:image_picker/image_picker.dart';

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
              MaterialButton(
                onPressed: () async {
                  final Uint8List? imageBytes = await _captureImageFromCamera();
                  setState(() {
                    _fileData = imageBytes;
                  });
                },
                color: Colors.blue,
                child: const SizedBox(
                  child: Center(
                    child: Text(
                      "Capture Image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
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

  Future<Uint8List?> _captureImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return await pickedFile.readAsBytes();
    }

    return null;
  }
}
