
import 'package:flutter/material.dart';
import 'package:todo_app/data/local_data_source.dart';
import 'package:todo_app/domain/repository/them_repository.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

late final TodoRepository repository;
late final ThemeRepository themeRepository;
late final ValueNotifier<ThemeMode> mode;

Future<void> serviceLocator()async{
  /// third party api => storage
  final db = await LocalDataSourceImpl.init;
  ///data

  LocalDataSource dataSource = LocalDataSourceImpl(db: db);

  ///repository
  repository= TodoRepositoryImpl(dataSource: dataSource);
  themeRepository = ThemeRepositoryImpl(dataSource: dataSource) ;

  mode = ValueNotifier(themeRepository.getMode());
}