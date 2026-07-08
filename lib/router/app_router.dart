import 'package:go_router/go_router.dart';

import '../auth/presentation/screens/login_screen.dart';
import '../auth/presentation/screens/register_screen.dart';
import '../features/pairing/presentation/screens/pair_screen.dart';
import '../features/pairing/presentation/screens/qr_scanner_screen.dart';
import '../features/permission/presentation/screens/permission_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",

  routes: [

    GoRoute(
      path: "/",
      builder: (context, state) => const PermissionScreen(),
    ),

    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: "/register",
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: "/pair",
      builder: (context, state) => const PairScreen(),
    ),


    GoRoute(
      path: "/scanner",
      builder: (context, state) => const QRScannerScreen(),
    ),

    GoRoute(
      path: "/permission",
      builder: (context, state) => const PermissionScreen(),
    ),
  ],
);