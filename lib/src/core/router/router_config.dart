import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stadium_app_task/src/core/router/app_route_name.dart';
import 'package:stadium_app_task/src/feature/bookmark/bookmark.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/home_page.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/home_page_map.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/main_page.dart';
import 'package:stadium_app_task/src/feature/profile/profile_page.dart';

final class RouteSystem {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorBookmark = GlobalKey<NavigatorState>(debugLabel: 'shellBookmark');
  static final _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  static GoRouter goRouter = GoRouter(
    initialLocation: AppRouteName.home,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// Splash
      // GoRoute(
      //   path: AppRouteName.splash,
      //   builder: (context, state) => const SplashPage(),
      // ),

      /// Main SHell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainPage(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          /// Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: AppRouteName.home,
                builder: (context, state) => const HomePageMap(),
              ),
            ],
          ),

          /// Raiting
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBookmark,
            routes: <RouteBase>[
              GoRoute(
                path: AppRouteName.bookmarks,
                builder: (context, state) => const BookmarkPage(),
              ),
            ],
          ),

          /// Profile
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
