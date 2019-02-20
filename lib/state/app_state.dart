import 'package:meta/meta.dart';
import 'package:todo_redux_example/model/model.dart';

class AppState {
  final List<Item> items;

  AppState({@required this.items});

  AppState.initialState() : items = List.unmodifiable(<Item>[]);

  AppState.fromJson(Map json)
      : items =
            (json['items'] as List).map((item) => Item.fromJson(item)).toList();

  Map toJson() => {'items': items};
}
