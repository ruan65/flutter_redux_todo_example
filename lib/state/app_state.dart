import 'package:meta/meta.dart';
import 'package:todo_redux_example/model/model.dart';

class AppState {
  final List<Item> items;

  AppState({@required this.items});

  AppState.initialState() : items = List.unmodifiable(<Item>[]);
}