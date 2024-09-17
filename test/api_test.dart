import 'package:t4f_challenge_app/repository/api.dart';
import 'package:test/test.dart';

void main() {
  test('Testing Api', () async {
    var items = await AppApi.getItems();
    //Our api has static items, which means we can expect exactly same items in test:
    expect(items, isList);
    expect(items.length, equals(15));
    expect(items.first, isIn(items));
    expect(items.first.title, 'Rustic Wooden Shirt');
  });
}
