import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/ui/component/goski_switch.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:logger/logger.dart';

void main() {
  testWidgets('GoskiSwitch test', (WidgetTester tester) async {
    Logger logger = Logger();

    // ScreenSizeController 초기화
    Get.put(ScreenSizeController());

    // 위젯이 화면에 그려질 때까지 기다림
    await tester.pumpAndSettle();

    final screenSizeController = Get.find<ScreenSizeController>();
    screenSizeController.setScreenSize(800, 600);
    double halfSize = screenSizeController.getWidthByRatio(0.5);

    logger.d(halfSize);

    // 테스트 위젯을 비동기로 초기화
    await tester.runAsync(() async {
      // 화면 크기 설정
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Center(
                  child: GoskiSwitch(
                    items: ['스키', '보드'],
                    width: halfSize,
                  ),
                );
              },
            ),
          ),
        ),
      );

      // 너비가 정확히 계산되었는지 확인
      expect(find.byType(GoskiSwitch), findsOneWidget);
      expect(tester.getSize(find.byType(GoskiSwitch)).width, halfSize); // 화면 너비의 반
    });
  });
}
