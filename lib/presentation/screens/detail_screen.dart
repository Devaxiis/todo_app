import 'package:flutter/material.dart';
import 'package:todo_app/core/service_locator.dart';
import 'package:todo_app/domain/models/todo_model.dart';


class Detail extends StatefulWidget {
  final int count;
  const Detail({
    Key? key,
    required this.count
  }
      ) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerImage = TextEditingController();

  void addData() async {
    final title = controllerTitle.value.text.trim();
    final description = controllerDescription.value.text.trim();
    final imageUrl = controllerImage.value.text.trim();


    await repository.storeTodo(Todo(id: widget.count+1, title: title, description: description,imageUrl: imageUrl));

    Navigator.of(context).pop("d");
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



