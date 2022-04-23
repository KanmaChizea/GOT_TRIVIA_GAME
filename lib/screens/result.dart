import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:got_trivia_game/globals.dart';
import 'package:got_trivia_game/screens/home.dart';
import 'package:got_trivia_game/screens/statistics.dart';
import 'package:got_trivia_game/services/database/database.dart';
import 'package:got_trivia_game/services/trivia_controller.dart';
import 'package:got_trivia_game/styles/buttons.dart';
import 'package:got_trivia_game/styles/texts.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Color resultbar;
  late String resultMessage;
  late MyDatabase database;

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
    database = Provider.of<MyDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 100,
        leading: TextButton.icon(
            onPressed: () {
              setState(() {
                globalList = [];
                totalScore = 0;
                unanswered = 0;
              });
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false);
            },
            icon: const Icon(Icons.home_outlined),
            label: const Text('Home'),
            style: TextButton.styleFrom(
              primary: const Color.fromARGB(255, 185, 194, 218),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        actions: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                globalList = [];
                totalScore = 0;
                unanswered = 0;
              });
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            icon: const Icon(Icons.exit_to_app),
            label: const Text('Exit'),
            style: TextButton.styleFrom(
              primary: const Color.fromARGB(255, 185, 194, 218),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              onPressed: () async {
                await database.addScore(
                    score: totalScore, unanswered: unanswered);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.grey.shade800,
                  content: const Text(
                    'Saved!',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 1),
                ));
              },
              icon: const Icon(Icons.save_alt_outlined),
              label: const Text('Save score'),
              style: elevatedButtonStyle(),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  globalList = [];
                  totalScore = 0;
                  unanswered = 0;
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
                  MaterialPageRoute(
                      builder: (context) => const StatisticsScreen()),
                );
              },
              icon: const Icon(Icons.bar_chart_outlined),
              label: const Text('Statistics'),
              style: elevatedButtonStyle(),
            ),
            Flexible(child: Container())
          ],
        ),
      ),
    );
  }

  Stack showResultWidget(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
        height: 200,
        width: 200,
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey.shade300,
          color: totalScore >= 5 ? Colors.green : Colors.red,
          strokeWidth: 15,
          value: totalScore / 10,
        ),
      ),
      Text(
        '$totalScore/10',
        style: result(),
      )
    ]);
  }
}
