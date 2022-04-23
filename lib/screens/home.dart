import 'package:flutter/material.dart';
import 'package:got_trivia_game/screens/statistics.dart';
import 'package:got_trivia_game/services/trivia_controller.dart';
import 'package:got_trivia_game/styles/buttons.dart';

import '../components/got_text.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(child: Container()),
          SizedBox(height: size.height / 3, child: const GOTtext()),
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
          // SizedBox(
          //   width: 170,
          //   height: 130,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          ElevatedButton(
              style: elevatedButtonStyle(),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const TriviaController()),
                  (route) => false),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Start'),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward)
                ],
              )),
          const SizedBox(height: 15),
          ElevatedButton(
            style: elevatedButtonStyle(),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const StatisticsScreen()),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Statistics'),
                SizedBox(width: 8),
                Icon(Icons.bar_chart_outlined)
                //   ],
                // )),
              ],
            ),
          ),
          Flexible(child: Container())
        ]),
      ),
    );
  }
}
