import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stadium_app_task/setup.dart';
import 'package:stadium_app_task/src/core/router/app_route_name.dart';
import 'package:stadium_app_task/src/feature/bookmark/bookmark.dart';
import 'package:stadium_app_task/src/feature/connection/view/pages/connection_page.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/home_page.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/main_page.dart';
import 'package:stadium_app_task/src/feature/profile/profile_page.dart';

final class RouteSystem {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorBookmark = GlobalKey<NavigatorState>(debugLabel: 'shellBookmark');
  static final _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  static GoRouter goRouter = GoRouter(
    initialLocation: isConneted ? AppRouteName.home : AppRouteName.connection,
    // initialLocation: InhertedConnectionNotifair.maybeOf(context).isDeviceConnectionEnable,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRouteName.connection,
        builder: (context, state) => const ConnectionPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainPage(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: AppRouteName.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBookmark,
            routes: <RouteBase>[
              GoRoute(
                path: AppRouteName.bookmarks,
                builder: (context, state) => const BookmarkPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: <RouteBase>[
              GoRoute(
                path: AppRouteName.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
