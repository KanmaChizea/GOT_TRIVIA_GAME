import 'package:flutter/material.dart';

class GOTtext extends StatelessWidget {
  const GOTtext({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Image.asset('lib/assets/logo.png')),
        Positioned(
          bottom: 150,
          left: 45,
          child: Text(
            'GAME OF THRONES',
            style: TextStyle(
              fontSize: 33,
              fontFamily: 'AbhayaLibre',
              letterSpacing: 1,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = Colors.orange,
            ),
          ),
        ),
        const Positioned(
          bottom: 150,
          left: 45,
          child: Text(
            'GAME OF THRONES',
            style: TextStyle(
                fontSize: 33,
                letterSpacing: 1,
                color: Colors.white,
                fontFamily: 'AbhayaLibre'),
          ),
        )
      ],
    );
  }
}
