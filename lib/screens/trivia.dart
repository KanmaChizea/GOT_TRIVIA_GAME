import 'package:flutter/material.dart';
import 'package:got_trivia_game/components/questions.dart';
import 'package:got_trivia_game/styles/texts.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('GOT Trivia'),
          centerTitle: true,
          titleTextStyle: headings(),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            QuestionsBuild(index: index, data: data),
            Expanded(
              child: OptionsBuild(
                correctAnswer: data['answer'],
                questionIndex: widget.questionIndex,
              ),
            ),
            const SizedBox(height: 30),
          ]),
        )));
  }
}
