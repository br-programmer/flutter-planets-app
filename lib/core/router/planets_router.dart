import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';
import 'package:riverpod/riverpod.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: PlanetsRoutes.home.path,
    routes: PlanetsRouter.routes(),
    debugLogDiagnostics: ref.read(Providers.env).enableLogging,
  ),
);

class PlanetsRouter {
  const PlanetsRouter._();

  static List<RouteBase> routes() => [
        GoRoute(
          path: PlanetsRoutes.home.path,
          name: PlanetsRoutes.home.name,
          builder: HomeScreen.builder,
        ),
        GoRoute(
          path: PlanetsRoutes.planets.path,
          name: PlanetsRoutes.planets.name,
          builder: PlanetsScreen.builder,
          routes: [
            GoRoute(
              path: PlanetsRoutes.planet.path,
              name: PlanetsRoutes.planet.name,
              builder: PlanetScreen.builder,
            ),
          ],
        ),
      ];
}
