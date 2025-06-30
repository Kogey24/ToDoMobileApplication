import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/Model/todo.dart';
import 'package:todoapp/Providers/todo_provider.dart';

class completedTodos extends ConsumerWidget {
  const completedTodos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> completeTodos =
        todos.where((todo) => todo.completed == true).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TodoApp'),
      ),
      body: ListView.builder(
        itemCount: completeTodos.length,
        itemBuilder: (context, index) {
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
            child: ListTile(
              title: Text(completeTodos[index].content),
            ),
          );
        },
      ),
    );
  }
}
