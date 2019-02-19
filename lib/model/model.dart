import 'package:meta/meta.dart';

class Item {
  final int id;
  final String body;

  Item({
    @required this.id,
    @required this.body,
  });

  Item copyWith({int id, String body}) => Item(
        id: id ?? this.id,
        body: body ?? this.body,
      );

  Item.fromJson(Map json)
      : body = json['body'],
        id = json['id'];

  Map toJson() => {
        'id': id,
        'body': body,
      };
}
