import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets/core/core.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const HomeScreen._();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => context.goNamed(PlanetsRoutes.planets.name),
          child: const Text('Ver Planetas'),
        ),
      ),
    );
  }
}
