import 'package:flutter/material.dart';
import 'package:got_trivia_game/styles/texts.dart';

class QuestionsBuild extends StatelessWidget {
  const QuestionsBuild({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  final int index;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Question $index/10',
            style: headings(),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          '"${data['question']}',
          style: body(),
        ),
      ],
    );
  }
}
