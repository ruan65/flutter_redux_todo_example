import 'package:todo_redux_example/model/model.dart';
import 'package:todo_redux_example/state/app_state.dart';

class AddItemAction {
  static int _id = 0;
  final String item;

  AddItemAction(this.item) {
    _id++;
  }

  get id => _id;
}

class RemoveItemAction {
  final Item item;

  RemoveItemAction(this.item);
}

class RemoveAllItemsAction{}
