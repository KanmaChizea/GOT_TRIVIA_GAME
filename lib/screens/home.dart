import 'package:flutter/material.dart';
import 'package:got_trivia_game/services/trivia_controller.dart';
import 'package:got_trivia_game/styles/buttons.dart';

import '../components/got_text.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height / 2, child: const GOTtext()),
                const SizedBox(height: 15),
                const Text('TRIVIA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'FasterOne',
                    )),
                const SizedBox(height: 10),
                const Text('Guess who said what',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'PlayBall',
                        letterSpacing: 1.0)),
                const SizedBox(height: 50),
                ElevatedButton(
                    style: elevatedButtonStyle(),
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const TriviaController()),
                        (route) => false),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text('START'),
                        Icon(Icons.arrow_forward)
                      ],
                    ))
              ]),
        ));
  }
}
