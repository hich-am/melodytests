import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AmbientBackground extends StatelessWidget {
  final Widget child;

  const AmbientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background color
        Container(color: AppColors.background),
        // Ambient glows
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.10),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
              child: Container(color: Colors.transparent),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          right: -100,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary.withOpacity(0.10),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
              child: Container(color: Colors.transparent),
            ),
          ),
        ),
        // Foreground content
        SafeArea(child: child),
      ],
    );
  }
}
