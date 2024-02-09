import 'dart:io';

import 'package:app/pages/auth_page.dart';
import 'package:app/pages/chat_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/services/locator.dart';
import 'package:app/stores/auth_store.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authStore = it.get<AuthStore>();

    return ResponsiveSizer(builder: (context, or, screenType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(41, 47, 63, 1),
          fontFamily: GoogleFonts.abhayaLibre().fontFamily,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Theme.of(context).colorScheme.secondary,
            selectionColor: Theme.of(context).colorScheme.secondary,
            selectionHandleColor: Theme.of(context).colorScheme.secondary,
          ),
          inputDecorationTheme: inputDecorations(context),
          textTheme: textStyle(context),
          elevatedButtonTheme: elevatedButtonTheme(context),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(39, 42, 53, 1),
            secondary: const Color.fromRGBO(55, 62, 78, 1),
            primary: const Color.fromRGBO(39, 42, 53, 1),
            tertiary: const Color.fromARGB(255, 42, 105, 252),
          ),
        ),
        onGenerateInitialRoutes: (initialRoute) {
          return [
            MaterialPageRoute(
              builder: (context) =>
                  authStore.isLoggedIn ? const HomePage() : const AuthPage(),
            ),
          ];
        },
        onGenerateRoute: (settings) {
          if (settings.name == ChatPage.route) {
            final roomId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => ChatPage(roomId: roomId),
            );
          }
          if (settings.name == AuthPage.route) {
            return MaterialPageRoute(
              builder: (context) => const AuthPage(),
            );
          }
          if (settings.name == HomePage.route) {
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
          }
          return null;
        },
      );
    });
  }
}
