import 'package:todo_redux_example/model/model.dart';
import 'package:todo_redux_example/state/app_state.dart';
import 'package:todo_redux_example/state/redux/actions.dart';

import 'package:redux/redux.dart';

AppState appStateReducer(AppState prevState, dynamic action) {
  return AppState(
    items: itemCombinedReducer(prevState.items, action),
  );
}

Reducer<List<Item>> itemCombinedReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveAllItemsAction>(removeAllItemsReducer),
  TypedReducer<List<Item>, RemoveItemAction>(removeItemReducer),
  TypedReducer<List<Item>, LoadedItemsAction>(loadItemsReducer),
  TypedReducer<List<Item>, ItemCompletedAction>(itemCompletedReducer),
]);

List<Item> addItemReducer(List<Item> items, AddItemAction action) => []
  ..addAll(items)
  ..add(Item(id: action.id, body: action.item));

List<Item> removeItemReducer(List<Item> items, RemoveItemAction action) =>
    List.unmodifiable(List.from(items)..remove(action.item));

List<Item> removeAllItemsReducer(
        List<Item> items, RemoveAllItemsAction action) =>
    List.unmodifiable([]);

List<Item> loadItemsReducer(List<Item> items, LoadedItemsAction action) =>
    action.items;

List<Item> itemCompletedReducer(List<Item> items, ItemCompletedAction action) =>
    items
        .map((item) => item.id == action.item.id
            ? item.copyWith(finished: !item.completed)
            : item)
        .toList();
