import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_automation_promo/app.dart';

void main() {
  testWidgets('App loads hero section', (WidgetTester tester) async {
    await tester.pumpWidget(const SotongAutomationApp());

    expect(find.textContaining('산업자동화'), findsWidgets);
    expect(find.text('주요 기능 보기'), findsOneWidget);
    expect(find.text('소통웨어 산업자동화'), findsWidgets);
  });
}
