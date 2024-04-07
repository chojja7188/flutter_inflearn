import 'package:flutter/material.dart';
import 'package:flutter_go_router_sample/main/main_screen.dart';
import 'package:flutter_go_router_sample/main/result_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'result',
          builder: (BuildContext context, GoRouterState state) {
            return ResultScreen(
              weight: double.parse(state.uri.queryParameters['weight']!),
              height: double.parse(state.uri.queryParameters['height']!)
            );
          },
        ),
      ],
    ),
  ],
);
