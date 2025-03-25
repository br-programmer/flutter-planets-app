import 'package:flutter/material.dart';

class PlanetsResponsiveScreen extends StatelessWidget {
  const PlanetsResponsiveScreen({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => switch (constraints.maxWidth) {
        < 600 => mobile,
        < 1024 => tablet,
        _ => desktop,
      },
    );
  }
}
