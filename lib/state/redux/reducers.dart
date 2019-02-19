import 'package:todo_redux_example/model/model.dart';
import 'package:todo_redux_example/state/app_state.dart';
import 'package:todo_redux_example/state/redux/actions.dart';

AppState appStateReducer(AppState prevState, dynamic action) {
  return AppState(
    items: itemReducer(prevState.items, action),
  );
}

List<Item> itemReducer(List<Item> state, dynamic action) {

  if(action is AddItemAction) {
    return []
        ..addAll(state)
        ..add(Item(id: action.id, body: action.item));
  }

  if(action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  if(action is RemoveAllItemsAction) {
    return List.unmodifiable([]);
  }


  return state;
}
