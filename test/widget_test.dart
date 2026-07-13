import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sotong_automation_promo/app.dart';
import 'package:sotong_automation_promo/widgets/mobile_navigation.dart';

void _setViewSize(WidgetTester tester, Size size) {
  final view = tester.view;
  view.physicalSize = size;
  view.devicePixelRatio = 1.0;
  addTearDown(view.resetPhysicalSize);
  addTearDown(view.resetDevicePixelRatio);
}

void main() {
  testWidgets('App loads hero and worker-focused intro', (
    WidgetTester tester,
  ) async {
    _setViewSize(tester, const Size(1366, 768));
    await tester.pumpWidget(const SotongAutomationApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.textContaining('산업자동화'), findsWidgets);
    expect(find.text('문의하기'), findsWidgets);
    expect(find.text('데모 요청하기'), findsNothing);
    expect(find.text('소통웨어'), findsWidgets);
    expect(find.textContaining('작업자'), findsWidgets);
    expect(find.textContaining('작업자 중심 화면'), findsWidgets);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Forbidden promo claims are absent', (WidgetTester tester) async {
    _setViewSize(tester, const Size(1366, 768));
    await tester.pumpWidget(const SotongAutomationApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('데모 요청하기'), findsNothing);
    expect(find.textContaining('AI 분석'), findsNothing);
    expect(find.textContaining('예지보전'), findsNothing);
    expect(find.textContaining('SCADA'), findsNothing);
    expect(find.textContaining('Integrated Control Room'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Mobile shows bottom nav and hides desktop nav links', (
    WidgetTester tester,
  ) async {
    _setViewSize(tester, const Size(390, 844));
    await tester.pumpWidget(const SotongAutomationApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(MobileBottomNavBar), findsOneWidget);
    expect(find.text('소개'), findsWidgets);
    expect(find.text('핵심기능'), findsWidgets);
    expect(find.text('연동대상'), findsWidgets);
    expect(find.byTooltip('전체메뉴'), findsOneWidget);
    expect(find.text('시스템구성도'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Desktop shows top nav and hides mobile bottom bar', (
    WidgetTester tester,
  ) async {
    _setViewSize(tester, const Size(1366, 768));
    await tester.pumpWidget(const SotongAutomationApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('시스템소개'), findsWidgets);
    expect(find.text('시스템구성도'), findsWidgets);
    expect(find.byType(MobileBottomNavBar), findsNothing);
    expect(find.byTooltip('전체메뉴'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Full menu opens and closes after selection', (
    WidgetTester tester,
  ) async {
    _setViewSize(tester, const Size(390, 844));
    await tester.pumpWidget(const SotongAutomationApp());
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byTooltip('전체메뉴'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('전체메뉴'), findsWidgets);
    expect(find.text('시스템 소개'), findsWidgets);

    await tester.tap(find.text('시스템 소개').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.byType(MobileFullMenuSheet), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });

  for (final size in <Size>[
    const Size(360, 800),
    const Size(390, 844),
    const Size(768, 1024),
    const Size(1366, 768),
    const Size(1920, 1080),
  ]) {
    testWidgets(
      'Landing page renders without overflow at ${size.width}x${size.height}',
      (WidgetTester tester) async {
        _setViewSize(tester, size);
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
