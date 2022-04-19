import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:got_trivia_game/globals.dart';
import 'package:got_trivia_game/screens/home.dart';
import 'package:got_trivia_game/screens/statistics.dart';
import 'package:got_trivia_game/services/trivia_controller.dart';
import 'package:got_trivia_game/styles/buttons.dart';
import 'package:got_trivia_game/styles/texts.dart';
import 'package:got_trivia_game/globals.dart' as globals;

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Color resultbar;
  late String resultMessage;

  @override
  void initState() {
    resultMessage = message();
    super.initState();
  }

  String message() {
    String resultMessage;
    if (totalScore < 4) {
      resultMessage = 'Did you even watch this show?';
    } else if (totalScore >= 4 && totalScore < 7) {
      resultMessage = 'You tried, boss! No stress';
    } else if (totalScore >= 7 && totalScore < 9) {
      resultMessage = 'Nice! Hope you know book reach like this';
    } else {
      resultMessage = 'Boss Levels!!! How many times have you seen this show?';
    }
    return resultMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                            (route) => false);
                      },
                      icon: const Icon(Icons.home_outlined),
                      label: const Text('Home'),
                      style: TextButton.styleFrom(
                        primary: const Color.fromARGB(255, 185, 194, 218),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  TextButton.icon(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Exit'),
                    style: TextButton.styleFrom(
                      primary: const Color.fromARGB(255, 185, 194, 218),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Flexible(child: Container()),
              Text('RESULT', style: headings()),
              const SizedBox(height: 30),
              showResultWidget(context),
              const SizedBox(height: 30),
              Text(
                resultMessage,
                style: body(),
              ),
              Flexible(child: Container()),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    globalList = [];
                    totalScore = 0;
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const TriviaController()),
                      (route) => false);
                },
                icon: const Icon(Icons.replay),
                label: const Text('Play again'),
                style: elevatedButtonStyle(),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Statistics()),
                  );
                },
                icon: const Icon(Icons.leaderboard_outlined),
                label: const Text('Statistics'),
                style: elevatedButtonStyle(),
              ),
              Flexible(child: Container())
            ],
          ),
        ));
  }

  Stack showResultWidget(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: globals.totalScore < 5 ? Colors.red : Colors.green,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: MediaQuery.of(context).size.width / 2 - 105,
          child: Container(
            width: 170,
            height: 170,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black),
            child: Center(
                child: Text(
              '$totalScore/10',
              style: result(),
            )),
          ),
        )
      ],
    );
  }
}
