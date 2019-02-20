import 'package:meta/meta.dart';

class Item {
  final int id;
  final String body;
  bool competed;

  Item({
    @required this.id,
    @required this.body,
    this.competed = false,
  });

  Item copyWith({int id, String body, bool finished}) => Item(
        id: id ?? this.id,
        body: body ?? this.body,
        competed: finished ?? this.competed,
      );

  Item.fromJson(Map json)
      : body = json['body'],
        id = json['id'],
        competed = json['completed'];

  Map toJson() => {
        'id': id,
        'body': body,
        'completed': competed,
      };

  @override
  String toString() => toJson().toString();
}
