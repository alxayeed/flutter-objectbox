import 'package:flutter/material.dart';
import 'package:flutter_objectbox/todo/screens/task_add_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Task $index'),
            subtitle: Text('Description of Task $index'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: const Center(child: Text("Add Task")),
              content: TaskAddScreen(),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
