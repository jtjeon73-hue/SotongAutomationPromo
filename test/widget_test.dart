import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_automation_promo/app.dart';

void main() {
  testWidgets('App loads hero section', (WidgetTester tester) async {
    await tester.pumpWidget(const SotongAutomationApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.textContaining('산업자동화'), findsWidgets);
    expect(find.text('문의하기'), findsWidgets);
    expect(find.text('데모 요청하기'), findsNothing);
    expect(find.text('소통웨어'), findsWidgets);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  for (final size in <Size>[
    const Size(390, 844),
    const Size(1366, 768),
    const Size(1920, 1080),
  ]) {
    testWidgets(
      'Landing page renders without overflow at ${size.width}x${size.height}',
      (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(size);
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(const SotongAutomationApp());
        await tester.pump(const Duration(seconds: 1));

        expect(find.textContaining('산업자동화'), findsWidgets);
        expect(find.text('문의하기'), findsWidgets);
        expect(find.text('데모 요청하기'), findsNothing);
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(const SizedBox.shrink());
      },
    );
  }
}
