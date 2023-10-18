
import 'package:bike_services_vendor/dashboard/add_photo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../dashboard/dashboard.dart';
import '../screens/error_widget.dart' as e;
import '../screens/login_page.dart';
import '../screens/otp/otp_screen.dart';
import '../screens/profile_page.dart';
import '../screens/splash.dart';
import 'app_routes_constant.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
      routes: [
        GoRoute(
            name: AppConstantRoute.splashRoute,
            path: "/",
            builder: (BuildContext context, GoRouterState state) {
              return const SplashScreen();
            }),
        GoRoute(
            name: AppConstantRoute.loginRoute,
            path: "/login_page",
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            }),
        GoRoute(
            name: AppConstantRoute.otpRoute,
            path: "/otpRoute",
            builder: (BuildContext context, GoRouterState state) {
              var sample = state.extra as Map<String,dynamic> ; // -> casting is important
              return  OtpScreen(number:sample['mobile'], otp: sample['otp'],);
            }),
        GoRoute(
          name: AppConstantRoute.dashboardRoute,
          path: "/dashboard",
          builder: (BuildContext context,GoRouterState state){
            return const DashBoardScreen();
          }
        ),
        GoRoute(
          name: AppConstantRoute.profileRoute,
          path: "/profile_page",
          builder: (BuildContext context,GoRouterState state){
            return const ProfileScreen();
          }
        ),
        GoRoute(
          name: AppConstantRoute.addPhotoRoute,
          path: "/add_photo",
          builder: (BuildContext context,GoRouterState state){
            var order = state.extra as String;
            return  AddPhotos(orderId: order,);
          }
        ),



      ],
      errorBuilder: (context, state) {
        return e.ErrorWidget(error: state.error.toString());
      });
}
