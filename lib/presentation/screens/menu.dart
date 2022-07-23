import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:got_trivia_game/logic/cubit/audio_cubit.dart';
import 'package:got_trivia_game/logic/cubit/stats_cubit.dart';

import '../../logic/bloc/questions_bloc.dart';
import '../../utils/clicksound.dart';
import '../components/got_text.dart';
import '../components/iconbutton.dart';
import '../styles/buttons.dart';
import '../styles/colors.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
            onPressed: () {
              playClick(context);
              Future.delayed(
                  const Duration(seconds: 1),
                  () => BlocProvider.of<QuestionsBloc>(context)
                      .add(LoadQuestions()));
            },
            child: const Text('PLAY')),
        const SizedBox(height: 15),
        ElevatedButton(
            style: elevatedButtonStyle,
            onPressed: () {
              playClick(context);
              context.read<StatsCubit>().getStats();
              Future.delayed(const Duration(seconds: 1),
                  () => Navigator.of(context).pushNamed('stats'));
            },
            child: const Text('STATISTICS')),
        Flexible(child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuIconButtons(
                icon: Icons.music_note,
                secondaryIcon: Icons.music_off,
                onPressed: () {
                  context.read<SoundCubit>().toggle();
                }),
            SizedBox(width: MediaQuery.of(context).size.width / 4),
            MenuIconButtons(
                icon: Icons.volume_up,
                secondaryIcon: Icons.volume_off,
                onPressed: () {
                  context.read<MusicCubit>().toggle();
                }),
          ],
        )
      ]),
    );
  }
}
