import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_redux_example/model/model.dart';
import 'package:todo_redux_example/state/app_state.dart';
import 'package:todo_redux_example/state/redux/actions.dart';
import 'package:todo_redux_example/state/redux/reducers.dart';
import 'package:todo_redux_example/state/redux/middleware.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DevToolsStore<AppState> store = DevToolsStore<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
      middleware: [appStateMiddleware],
    );

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(GetItemsAction()),
          builder: (BuildContext ctx, Store<AppState> store) =>
              MyHomePage(store: store),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final DevToolsStore<AppState> store;

  MyHomePage({Key key, this.title, this.store}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redux Items'),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Column(
              children: <Widget>[
                AddItemWidget(viewModel),
                Expanded(child: TodoItemListWidget(model: viewModel)),
                RemoveItemsButtonWidget(model: viewModel),
              ],
            ),
      ),
      drawer: Container(
        child: ReduxDevTools(widget.store),
      ),
    );
  }
}

class TodoItemListWidget extends StatelessWidget {
  final _ViewModel model;

  const TodoItemListWidget({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        children: model.items
            .map((item) => ListTile(
                  title: Text(item.body),
                  leading: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => model.onRemoveItem(item),
                  ),
                ))
            .toList(),
      );
}

class RemoveItemsButtonWidget extends StatelessWidget {
  final _ViewModel model;

  const RemoveItemsButtonWidget({Key key, @required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        child: Text('Delete all Items'),
        onPressed: () => model.onRemoveAllItems(),
      );
}

class AddItemWidget extends StatefulWidget {
  final _ViewModel model;

  AddItemWidget(this.model);

  @override
  State<StatefulWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Add an Item'),
        onSubmitted: (String input) {
          widget.model.onAddItem(input);
          controller.text = '';
        },
      );
}

class _ViewModel {
  final List<Item> items;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveAllItems;

  _ViewModel({
    this.items,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveAllItems,
  });

  factory _ViewModel.create(Store<AppState> store) {
    _onAddItem(String body) {
      store.dispatch(AddItemAction(body));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveAllItem() {
      store.dispatch(RemoveAllItemsAction());
    }

    return _ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveAllItems: _onRemoveAllItem,
    );
  }
}
