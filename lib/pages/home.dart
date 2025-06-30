import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/Model/todo.dart';
import 'package:todoapp/Providers/todo_provider.dart';
import 'package:todoapp/pages/addtodo.dart';
import 'package:todoapp/pages/completed.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activetodos =
        todos.where((todo) => todo.completed == false).toList();
    List<Todo> completeTodos =
        todos.where((todo) => todo.completed == true).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TodoApp'),
      ),
      body: ListView.builder(
        itemCount: activetodos.length + 1,
        itemBuilder: (context, index) {
          if (index == activetodos.length) {
            if (completeTodos.isEmpty) {
              return Container();
            } else {
              return Center(
                child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const completedTodos())),
                    child: const Text("Completed Todos")),
              );
            }
          } else if (index < activetodos.length) {
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) =>
                        ref.watch(todoProvider.notifier).deleteTodo(index),
                    backgroundColor: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    icon: Icons.delete,
                  ),
                ],
              ),
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (context) =>
                      ref.watch(todoProvider.notifier).completeTodo(index),
                  backgroundColor: Colors.green,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  icon: Icons.check,
                )
              ]),
              child: ListTile(
                title: Text(activetodos[index].content),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTodo()),
          );
        },
        tooltip: 'Add Todo',
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
