import 'package:flutter/material.dart';
import 'package:todo_app/core/service_locator.dart';
import 'package:todo_app/domain/models/todo_model.dart';
import 'package:todo_app/presentation/views/add_todo.dart';
import 'package:todo_app/presentation/views/edit_todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// state manage
  List<Todo> todos = [];

  void getAllTodos() {
    todos = repository.readTodo();
    setState(() {});
  }

  void bottomClass(BuildContext context, int count) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Container(
            height: 500,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Detail(count: count));
      },
    );
    getAllTodos();
  }

  void bottomClass1(BuildContext context, Todo todo) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
            height: 500,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: EditScreen(todo: todo));
      },
    );
    getAllTodos();
  }

  void deleteTodo(Todo todo) {
    repository.deleteTodo(todo);
    getAllTodos();
  }

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  void changeTheme() async {
    if (mode.value == ThemeMode.light) {
      await themeRepository.setMode(ThemeMode.dark);
      mode.value = ThemeMode.dark;
    } else {
      await themeRepository.setMode(ThemeMode.light);
      mode.value = ThemeMode.light;
    }
  }

  /// ui => build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: changeTheme,
              icon: ValueListenableBuilder<ThemeMode>(
                valueListenable: mode,
                builder: (_, mode, child) {
                  return Icon(mode != ThemeMode.light
                      ? Icons.light_mode
                      : Icons.dark_mode);
                },
              )),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
     
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final data = todos[index];
            return Dismissible(
              crossAxisEndOffset: -5,
              key: ValueKey(todos[index]),
              // onUpdate: (details) => deleteTodo(data),
              onDismissed: (direction) => deleteTodo(data),
              background: const ColoredBox(
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: ListTile(
                  leading: CircleAvatar(child: Text(data.id.toString())),
                  title: Text(data.title),
                  trailing: IconButton(
                      onPressed: () => bottomClass1(context, data),
                      icon: const Icon(Icons.edit_document))),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bottomClass(context, todos.length),
        child: const Icon(Icons.add),
      ),
    );
  }
}
