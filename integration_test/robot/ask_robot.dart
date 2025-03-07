import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AskRobot {
  final WidgetTester tester;

  const AskRobot(this.tester);

  Future<void> loadUI(Widget widget) async {
    await tester.pumpWidget(widget);
  }

  Future<void> tapThemeSwitcher() async {
    final iconButtonFinder = find.byType(IconButton);
    await tester.tap(iconButtonFinder);
    await tester.pump();
  }

  Future<void> checkUpdatedIcon(icon) async {
    final iconButtonFinder = find.byType(IconButton);
    final iconInIconButtonFinder = find.descendant(
      of: iconButtonFinder,
      matching: find.byType(Icon),
    );
    final iconInIconButton = tester.widget<Icon>(iconInIconButtonFinder);
    expect(iconInIconButton.icon, icon);
  }

  Future<void> typeSearchQuery(String query) async {
    final textFieldFinder = find.byType(TextField);
    await tester.tap(textFieldFinder);
    await tester.enterText(textFieldFinder, query);
    await tester.testTextInput.receiveAction(TextInputAction.done);
  }

  Future<void> checkSuccessSearchResult(String result) async {
    expect(find.text(result), findsOneWidget);
  }
}
