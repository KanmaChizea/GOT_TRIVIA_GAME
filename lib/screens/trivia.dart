import 'package:flutter/material.dart';
import 'package:got_trivia_game/components/countdown.dart';
import 'package:got_trivia_game/components/questions.dart';

import '../components/options.dart';

// ignore: must_be_immutable
class Questions extends StatefulWidget {
  final int questionIndex;
  final Map questionInfo;
  const Questions({
    Key? key,
    required this.questionIndex,
    required this.questionInfo,
  }) : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  List optionsList = [];
  late int index;
  late final Map data;

  @override
  void initState() {
    index = widget.questionIndex;
    data = widget.questionInfo;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      child: ListView(shrinkWrap: true, children: [
        const SizedBox(height: 30),
        CountdownTimer(
          index: index,
        ),
        const SizedBox(height: 25),
        QuestionsBuild(index: index, data: data),
        OptionsBuild(
          correctAnswer: data['answer'],
          questionIndex: index,
        ),
      ]),
    )));
  }
}
