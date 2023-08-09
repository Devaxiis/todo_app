import 'package:flutter/material.dart';
import 'package:todo_app/core/service_locator.dart';

import 'package:todo_app/domain/models/todo_model.dart';

class EditScreen extends StatefulWidget {
  final Todo todo;

  const EditScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late final TextEditingController controllerTitle;

  void addData() async {
    final title = controllerTitle.value.text.trim();

    await repository.storeTodo(Todo(
      id: widget.todo.id,
      title: title,
    ));

    repository.deleteTodo(widget.todo);

    Navigator.of(context).pop();
  }

  void getOldUser() {
    controllerTitle = TextEditingController(text: widget.todo.title);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOldUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: addData,
            child: const Text("Save",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
          ),
          const SizedBox(width: 20,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: controllerTitle,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "title",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
