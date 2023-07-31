import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';

import 'package:todo_app/core/service_locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();

  runApp( const MyApp());

}