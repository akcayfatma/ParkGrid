import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkgrid_y/features/router/app_router.dart';
import 'package:parkgrid_y/temaBilesenleri/renkler.dart';
import 'package:parkgrid_y/temaBilesenleri/user_control_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:(context, ref, child){
      String ilkRoute=ref.read(userControllerRepositoryProvider).isUserSignedIn();

        return MaterialApp(
          title: 'Park Grid',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),
            scaffoldBackgroundColor: butonRengi,
            useMaterial3: true,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              unselectedItemColor: acikYazi,
              type: BottomNavigationBarType.fixed,
              backgroundColor: arkaplan,
            ),
          ),
          onGenerateRoute: AppRouter.generate,
          initialRoute: ilkRoute,
        );
      },
    );
  }
}