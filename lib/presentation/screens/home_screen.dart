import 'package:flutter/material.dart';
import 'package:todo_app/core/service_locator.dart';
import 'package:todo_app/domain/models/todo_model.dart';
import 'package:todo_app/presentation/screens/detail_screen.dart';
import 'package:todo_app/presentation/screens/edit_screen.dart';


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

  void addData() async{
    final data = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (e) =>  Detail(count: todos.length,)));
    if (data == "d") {
      getAllTodos();
    }
  }

  void deleteTodo(Todo todo) {
    repository.deleteTodo(todo);
    getAllTodos();
  }
  void clearTodo() {
    repository.clearCache();
    getAllTodos();
  }

  void editTodo(Todo todo) async{
    final data = await Navigator.of(context).push(MaterialPageRoute(builder: (e)=>EditScreen(todo: todo,)));
    if (data == "d") {
      getAllTodos();
    }
  }

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  /// ui => build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: clearTodo, icon:const Icon(Icons.folder_delete)),
          const SizedBox(width: 20,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final data = todos[index];
            return Card(
              child: ListTile(
                  leading: CircleAvatar(child: Text(data.id.toString())),
                  title: Text(data.title),
                  subtitle: Text(data.description),
                  trailing: PopupMenuButton(
                    itemBuilder: (e)=>[
                      PopupMenuItem(child: TextButton.icon(onPressed:()=> deleteTodo(data),icon:const Icon(Icons.delete),label: const Text("Delete"),),),
                      PopupMenuItem(child: TextButton.icon(onPressed: ()=> editTodo(data),icon:const Icon(Icons.edit),label: const Text("Edits"),),),
                    ],
                  )
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> addData(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
