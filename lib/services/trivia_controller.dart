import 'package:flutter/material.dart';
import 'package:got_trivia_game/globals.dart' as globals;

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
    _triviaApi = TriviaApi();
    super.initState();
  }

  getQuestions() async {
    final data = await _triviaApi.fetchData() as List;
    for (int i = 0; i < 10; i++) {
      final item = {
        'question': data[i]['sentence'],
        'answer': data[i]['character']['name'],
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
            globals.globalList = list;

            return Questions(
              questionIndex: questionIndex,
              questionInfo: list[questionIndex - 1],
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.orange),
          );
        });
  }
}
