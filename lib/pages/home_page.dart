import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/cubits/todo_cubit.dart';
import 'package:todo_application/data/models/todo_model.dart';

import '../components/dialog_box.dart';
import '../components/todo_tile.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final _controller = TextEditingController();

  void saveNewTask(BuildContext context) {
    context.read<TodoCubit>().addTodo(_controller.text);
    _controller.clear();
    Navigator.pop(context);
  }

  void cancelDialog(BuildContext context) {
    _controller.clear();
    Navigator.pop(context);
  }

  void createNewTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () => saveNewTask(context),
          onCancel:() =>  cancelDialog(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {Navigator.pushNamed(context, '/settingspage');},
              icon: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.settings),
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<TodoCubit,List<TodoModel>>(builder: (context,todoList){
        return ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(todoList[index].title),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                context.read<TodoCubit>().deleteTodo(index);
              },
              child: TodoTile(
                taskName: todoList[index].title,
                taskCompleted: todoList[index].isCompleted,
                onChanged: (value) => context.read<TodoCubit>().updateTodo(index),
              ),
            );
          },
        );
      },),
    );
  }
}
