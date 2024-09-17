import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:t4f_challenge_app/model/item_model.dart';
import 'package:t4f_challenge_app/view/screen/item_details_screen.dart';
import 'package:t4f_challenge_app/view/widget/item_widget.dart';
import 'package:t4f_challenge_app/viewmodel/home_view_model.dart';

Widget mockMainApp({required child}) {
  return ChangeNotifierProvider(
    create: (context) => HomeViewModel(),
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  var mockItem = ItemModel(
    type: 'Music',
    title: 'Mock title',
    price: 44.6,
    image: 'http://test.ir/test.png',
    city: 'London',
    presenter: 'AmirAbbas',
    runtime: 4,
    rate: 5,
    id: 3,
  );

  testWidgets('Testing Item Widget', (tester) async {
    await tester.pumpWidget(mockMainApp(child: ItemWidget(model: mockItem, onTap: () {})));
    expect(find.text(mockItem.title!), findsOneWidget);
    expect(find.text('\$${mockItem.price}'), findsOneWidget);
    expect(find.text('${mockItem.city}'), findsNothing);
  });

  testWidgets('Testing Details Screen', (tester) async {
    await tester.pumpWidget(mockMainApp(child: ItemDetailsScreen(model: mockItem)));
    expect(find.text(mockItem.title!), findsNWidgets(2));
    expect(find.text('\$${mockItem.price}'), findsOneWidget);
    expect(find.text('${mockItem.image}'), findsNothing);
    expect(find.text('${mockItem.city}'), findsOneWidget);
    expect(find.text('${mockItem.type}'), findsOneWidget);
    expect(find.text('Type:'), findsOneWidget);
    expect(find.text('Price:'), findsOneWidget);
    expect(find.text('City:'), findsNothing);
  });
}
