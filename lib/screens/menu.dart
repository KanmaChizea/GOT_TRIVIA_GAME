import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/got_text.dart';
import '../logic/bloc/questions_bloc.dart';
import '../styles/buttons.dart';
import '../styles/colors.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Flexible(child: Container()),
      SizedBox(height: size.height / 3, child: const GOTtext()),
      const SizedBox(height: 15),
      const Text('TRIVIA',
          style: TextStyle(
            color: white,
            fontSize: 40,
            fontFamily: 'FasterOne',
          )),
      const SizedBox(height: 10),
      const Text('Guess who said what',
          style: TextStyle(
              color: white,
              fontSize: 20,
              fontFamily: 'PlayBall',
              letterSpacing: 1.0)),
      const SizedBox(height: 50),
      ElevatedButton(
          style: elevatedButtonStyle,
          onPressed: () =>
              BlocProvider.of<QuestionsBloc>(context).add(LoadQuestions()),
          child: const Text('PLAY')),
      const SizedBox(height: 15),
      Flexible(child: Container()),
      Row(
        children: const [
          Icon(Icons.bar_chart),
          Icon(Icons.music_note),
          Icon(Icons.volume_up)
        ],
      )
    ]);
  }
}
