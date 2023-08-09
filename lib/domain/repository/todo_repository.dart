

import 'dart:convert';
import 'package:todo_app/data/local_data_source.dart';
import 'package:todo_app/domain/models/todo_model.dart';

abstract class TodoRepository{
  Future<bool> storeTodo(Todo todo);
  List<Todo> readTodo();
  Future<bool> deleteTodo(Todo todo);
  Future<bool> clearCache();
   Future<bool> editTodo(Todo todo);
}


class TodoRepositoryImpl implements TodoRepository{


  final LocalDataSource dataSource;
  const TodoRepositoryImpl({required this.dataSource});


  @override
  Future<bool> clearCache() {
    return dataSource.remove(StorageKey.todos);
  }

  @override
  Future<bool> deleteTodo(Todo todo) async{
    /// Object => json => String
    final list = readTodo();
    list.remove(todo);
    final json = list.map((todo) => todo.toJson()).toList();
    final data = jsonEncode(json);
    return await dataSource.store(StorageKey.todos, data);
  }

  @override
  List<Todo> readTodo() {
    /// String => json => Object
    String data = dataSource.read(StorageKey.todos) ?? "[]";
    final json = jsonDecode(data) as List;
    return json.map((item) => Todo.fromJson(item as Map<String, dynamic>)).toList();
  }

  @override
  Future<bool> storeTodo(Todo todo) async{
    /// Object => json => String
    final list = readTodo();
    list.add(todo);
    final json = list.map((tod) => tod.toJson()).toList();
    final data = jsonEncode(json);
    // print("--------${data}---------");
    return await dataSource.store(StorageKey.todos, data);
  }

   @override
  Future<bool> editTodo(Todo todo) {
    /// Object => json => String
    final list = readTodo();
    list.removeWhere((element) => element.id == todo.id);
    list.add(todo);
    final json = list.map((todo) => todo.toJson()).toList();
    final data = jsonEncode(json);
    return dataSource.store(StorageKey.todos, data);
  }

}