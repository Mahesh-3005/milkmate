import 'package:flutter/material.dart';

import 'colors.dart';

class _Card extends StatelessWidget {
  final Widget child;
  final bool gradient;

  const _Card({required this.child, this.gradient = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient:
            gradient
                ? const LinearGradient(
                  colors: [MilkLogColors.primary, MilkLogColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : null,
        color: gradient ? null : Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

Widget _pill(String label, int value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.25),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      "$label: $value",
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );
}