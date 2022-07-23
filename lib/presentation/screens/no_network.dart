import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/utils/clicksound.dart';

import '../../logic/bloc/questions_bloc.dart';
import '../styles/buttons.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 50, color: grey),
            const SizedBox(height: 10),
            const Text(
              "Something went wrong",
              style: body,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                playClick(context);
                Future.delayed(
                    const Duration(seconds: 1),
                    () => BlocProvider.of<QuestionsBloc>(context)
                        .add(LoadQuestions()));
              },
              icon: const Icon(Icons.repeat_rounded),
              label: const Text('Try again'),
              style: elevatedButtonStyle,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                playClick(context);
                Future.delayed(
                    const Duration(seconds: 1),
                    () => BlocProvider.of<QuestionsBloc>(context)
                        .add(NoQuestions()));
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go back'),
              style: elevatedButtonStyle,
            )
          ],
        ),
      ),
    );
  }
}
