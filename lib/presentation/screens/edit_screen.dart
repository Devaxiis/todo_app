import 'package:flutter/material.dart';
import 'package:todo_app/core/service_locator.dart';

import 'package:todo_app/domain/models/todo_model.dart';

class EditScreen extends StatefulWidget {
  final Todo todo;

  const EditScreen({Key? key, required this.todo, })
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late final TextEditingController controllerTitle;
  late final TextEditingController controllerDescription;
  late final TextEditingController controllerImage;

  void addData() async {
    final title = controllerTitle.value.text.trim();
    final description = controllerDescription.value.text.trim();
    final imageUrl = controllerImage.value.text.trim();

    await repository.storeTodo(Todo(
        id: widget.todo.id,
        title: title,
        description: description,
        imageUrl: imageUrl));


    repository.deleteTodo(widget.todo);


    Navigator.of(context).pop("d");
  }

  void getOldUser() {
    controllerTitle = TextEditingController(text: widget.todo.title);
    controllerDescription =
        TextEditingController(text: widget.todo.description);
    controllerImage = TextEditingController(text: widget.todo.imageUrl);
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
            child: const Text("Save"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controllerTitle,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "title",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: controllerDescription,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "description",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: controllerImage,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "Image url",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
