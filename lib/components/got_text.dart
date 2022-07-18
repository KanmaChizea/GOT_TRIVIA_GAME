import 'package:flutter/material.dart';
import 'package:got_trivia_game/styles/colors.dart';

class GOTtext extends StatelessWidget {
  const GOTtext({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Image.asset('lib/assets/logo.png')),
        Align(
          alignment: Alignment.center,
          child: Text(
            'GAME OF THRONES',
            style: TextStyle(
              fontSize: 33,
              fontFamily: 'AbhayaLibre',
              letterSpacing: 1,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = primary,
            ),
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'GAME OF THRONES',
            style: TextStyle(
                fontSize: 33,
                letterSpacing: 1,
                color: white,
                fontFamily: 'AbhayaLibre'),
          ),
        )
      ],
    );
  }
}
