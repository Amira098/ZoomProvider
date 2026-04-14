import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoom_provider/core/common/widget/empty_state_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  testWidgets('EmptyStateWidget displays text and icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScreenUtilInit(
            designSize: const Size(390, 844),
            builder: (context, child) => const EmptyStateWidget(
              icon: Icons.inbox,
              text: 'No data found',
            ),
          ),
        ),
      ),
    );

    expect(find.text('No data found'), findsOneWidget);
    expect(find.byIcon(Icons.inbox), findsOneWidget);
  });
}
