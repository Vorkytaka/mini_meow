import 'package:flutter/material.dart';
import 'package:mini_meow/game/game_screen.dart';
import 'package:mini_meow/main_menu/main_menu_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const MainMenuScreen(),
            );
          case '/game':
            return PageRouteBuilder(
              transitionsBuilder: (context, anim, _, child) {
                return child;
              },

              pageBuilder: (context, animation, secondaryAnimation) {
                return const GameScreen();
              },
            );
        }
      },
    );
  }
}
