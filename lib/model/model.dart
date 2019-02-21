import 'package:meta/meta.dart';

class Item {
  final int id;
  final String body;
  bool completed;

  Item({
    @required this.id,
    @required this.body,
    this.completed = false,
  });

  Item copyWith({int id, String body, bool finished}) => Item(
        id: id ?? this.id,
        body: body ?? this.body,
        completed: finished ?? this.completed,
      );

  Item.fromJson(Map json)
      : body = json['body'],
        id = json['id'],
        completed = json['completed'];

  Map toJson() => {
        'id': id,
        'body': body,
        'completed': completed,
      };

  @override
  String toString() => toJson().toString();
}
