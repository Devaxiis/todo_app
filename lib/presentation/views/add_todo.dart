import 'package:flutter/material.dart';
import 'package:todo_app/core/service_locator.dart';
import 'package:todo_app/domain/models/todo_model.dart';

class Detail extends StatefulWidget {
  final int count;
  const Detail({Key? key, required this.count}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  TextEditingController controllerTitle = TextEditingController();

  void addData() async {
    final title = controllerTitle.value.text.trim();

    await repository.storeTodo(Todo(id: widget.count + 1, title: title));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: addData,
            child: const Text(
              "Save",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
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
      ),
    );
  }
}
