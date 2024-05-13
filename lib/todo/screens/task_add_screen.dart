import 'package:flutter/material.dart';

class TaskAddScreen extends StatelessWidget {
  TaskAddScreen({super.key});

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
              //TODO add to box
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
