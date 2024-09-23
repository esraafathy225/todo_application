import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/cubits/todo_cubit.dart';
import 'package:todo_application/pages/home_page.dart';
import 'package:todo_application/pages/settings_page.dart';
import 'package:todo_application/themes/theme.dart';
import 'package:todo_application/themes/theme_provider.dart';

import 'data/models/todo_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  final todoBox = await Hive.openBox<TodoModel>('todoBox');
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MyApp(todoBox: todoBox),
  ));
}

class MyApp extends StatelessWidget {
  final Box<TodoModel> todoBox;

  const MyApp({super.key, required this.todoBox});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoCubit(todoBox),
        child: HomePage(),
      ),
      routes: {'/settingspage': (context) => SettingsPage()},
    );
  }
}
