import 'package:flutter/material.dart';
import '../../../core/constants/app_radius.dart';

class PhaseBadge extends StatelessWidget {
  final String title;

  const PhaseBadge({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEADDF8),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF7B4DB3),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}