import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Model/todo.dart';

final todoProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(String content) {
    state = [
      ...state,
      Todo(
          todoId: state.isEmpty ? 0 : state[state.length - 1].todoId,
          content: content,
          completed: false)
    ];
  }

  void completeTodo(int Id) {
    state = [
      for (final todo in state)
        if (todo.todoId == Id)
          Todo(todoId: todo.todoId, content: todo.content, completed: true)
        else
          todo
    ];
  }

  void deleteTodo(int id) {
    state = state.where((todo) => todo.todoId != id).toList();
  }
}
