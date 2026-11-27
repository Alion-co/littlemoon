import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/shared/widgets/avatar_carousel.dart';
import 'package:little_moon/shared/widgets/user_avatar.dart';

Widget _host(ValueNotifier<int> selected) {
  return MaterialApp(
    home: MediaQuery(
      // «کاهش حرکت»: بدون سرک‌کشیدن و بدون انیمیشن بی‌پایان
      data: const MediaQueryData(disableAnimations: true),
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 320,
            child: ValueListenableBuilder<int>(
              valueListenable: selected,
              builder: (context, value, _) => AvatarCarousel(
                selected: value,
                onChanged: (id) => selected.value = id,
                selectedColor: Colors.pink,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('لمس یک آواتار اون رو انتخاب می‌کنه', (tester) async {
    final selected = ValueNotifier<int>(0);
    await tester.pumpWidget(_host(selected));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.byType(UserAvatar).at(2));
    await tester.pump(const Duration(milliseconds: 100));

    expect(selected.value, 2);
  });

  testWidgets('با اسکرول به آخرین آواتار می‌رسیم', (tester) async {
    final selected = ValueNotifier<int>(0);
    await tester.pumpWidget(_host(selected));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.drag(find.byType(ListView), const Offset(-10000, 0));
    await tester.pump(const Duration(milliseconds: 500));

    expect(
      find.byWidgetPredicate(
        (w) => w is UserAvatar && w.avatarId == avatarCount,
      ),
      findsOneWidget,
    );
  });
}
