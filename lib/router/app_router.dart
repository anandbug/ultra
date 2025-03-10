// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:ultra/bonds/presentation/screens/bonds_details_screen.dart';
import 'package:ultra/bonds/presentation/screens/bonds_list_screen.dart';
import 'package:ultra/network/network_result.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => BondsListScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: '/bond-details',
            builder: (context, state) => BondsDetailsScreen(),
          ),
        ],
      ),
    ],
    //path/screen not found case not found
    errorBuilder:
        (context, state) => Center(child: const Text(kDefaultErrorMsg)),
  );

  static get router => _router;
}
