import 'package:flutter/material.dart';
import 'package:got_trivia_game/globals.dart' as globals;
import 'package:got_trivia_game/screens/trivia.dart';
import 'package:got_trivia_game/screens/result.dart';

class TriviaProcessing {
  answeredQuestion(int index, BuildContext context) {
    if (index < 10) {
      Navigator.of(context)
          .pushAndRemoveUntil(pageRouteBuilder(index), ((route) => false));
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ResultScreen()),
          (route) => false);
    }
  }

  PageRouteBuilder<dynamic> pageRouteBuilder(int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Questions(
        questionIndex: index + 1,
        questionInfo: globals.globalList[index],
      ),
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween =
            Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
          CurveTween(curve: Curves.ease),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
