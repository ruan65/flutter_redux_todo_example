import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_redux_example/model/model.dart';
import 'package:todo_redux_example/state/app_state.dart';
import 'package:todo_redux_example/state/redux/actions.dart';

const prefsKeyItemsState = 'prefsKeyItemsState';

void saveStateToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var encodedString = json.encode(state.toJson());
  await preferences.setString(prefsKeyItemsState, encodedString);
}

Future<AppState> loadFromPrefs() async {
  var prefs = await SharedPreferences.getInstance();
  var jsonString = prefs.getString(prefsKeyItemsState);

  if (null != jsonString) {
    Map map = json.decode(jsonString);
    return AppState.fromJson(map);
  }
  return AppState.initialState();
}

void appStateMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) async {
  next(action);

  if (action is AddItemAction ||
      action is RemoveItemAction ||
      action is RemoveAllItemsAction) {
    saveStateToPrefs(store.state);
  }

  if (action is GetItemsAction) {
    await loadFromPrefs()
        .then((state) => store.dispatch(LoadedItemsAction(state.items)));
  }
}
