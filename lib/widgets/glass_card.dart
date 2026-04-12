import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool border;
  final double blur;
  final Color? color;

  const GlassCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
    this.borderRadius = 16.0,
    this.border = true,
    this.blur = 40.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? AppColors.surfaceVariant.withOpacity(0.4),
            borderRadius: BorderRadius.circular(borderRadius),
            border: border
                ? Border.all(
                    color: AppColors.outline.withOpacity(0.15),
                    width: 1.0,
                  )
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
