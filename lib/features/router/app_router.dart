import 'package:flutter/material.dart';
import 'package:parkgrid_y/features/auth/views/sign_up.dart';
import 'package:parkgrid_y/models/user_model.dart';
import 'package:parkgrid_y/features/router/route_names.dart';

import 'package:parkgrid_y/features/auth/views/sign_in.dart';
import 'package:parkgrid_y/features/auth/views/sign_up_info.dart';
import 'package:parkgrid_y/features/home/views/home.dart';
import 'package:parkgrid_y/features/profile/views/edit_profile.dart';

class AppRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.home:
        return MaterialPageRoute(builder: (_) => const Home());

      case AppRouteNames.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());

      case AppRouteNames.signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());

      case AppRouteNames.signUpInfo:
        final arguments = settings.arguments as Map<String, dynamic>;
        final email = arguments['email'] as String;
        return MaterialPageRoute(
            builder: (_) => SignUpInfo(
                  email: email,
                ));
      
    

      case AppRouteNames.editProfile:
        final arguments = settings.arguments as Map<String, dynamic>;
        final currentUser = arguments['currentUser'] as UserModel;
        return MaterialPageRoute(
            builder: (_) => EditProfile(
                  currentUser: currentUser,
                ));

      default:
        return MaterialPageRoute(builder: (_) => const SignIn());
    }
  }
}