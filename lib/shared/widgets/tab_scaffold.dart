import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/features/home/widgets/floating_navbar.dart';

/// قاب مشترک صفحه‌های اصلی: محتوای قابل اسکرول + نوار پایین شناور.
///
/// دکمه‌ی برگشت اندروید توی این صفحه‌ها کاربر رو به خانه برمی‌گردونه
/// (به‌جای اینکه از برنامه خارج بشه).
class TabScaffold extends StatelessWidget {
  final int currentIndex;
  final List<Widget> children;

  const TabScaffold({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.go('/home');
      },
      child: Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
            FloatingNavbar(currentIndex: currentIndex),
          ],
        ),
      ),
      ),
    );
  }
}
