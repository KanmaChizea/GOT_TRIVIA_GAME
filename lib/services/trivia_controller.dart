import 'package:flutter/material.dart';
import 'package:got_trivia_game/globals.dart' as globals;
import 'package:got_trivia_game/globals.dart';
import 'package:got_trivia_game/screens/loading.dart';
import 'package:got_trivia_game/screens/no_network.dart';

import '../screens/trivia.dart';
import 'trivia_api.dart';

class TriviaController extends StatefulWidget {
  const TriviaController({Key? key}) : super(key: key);

  @override
  State<TriviaController> createState() => _TriviaControllerState();
}

class _TriviaControllerState extends State<TriviaController> {
  int questionIndex = 1;
  List<Map> list = [];
  late TriviaApi _triviaApi;

  @override
  void initState() {
    globals.totalScore = 0;
    globals.globalList = [];
    globals.unanswered = 0;
    _triviaApi = TriviaApi();

    super.initState();
  }

  getQuestions() async {
    final jsondata = await _triviaApi.fetchData();
    final data = jsondata["data"] as List;
    data.shuffle();
    for (int i = 0; i < 10; i++) {
      final item = {
        'question': data[i]['quote'],
        'answer': data[i]['character'],
      };

      list.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const NoNetwork();
            } else {
              globals.globalList = list;

              return Questions(
                questionIndex: questionIndex,
                questionInfo: list[questionIndex - 1],
              );
            }
          }
          return const LoadingScreen();
        });
  }
}
