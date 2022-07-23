import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/data/audio.dart';
import 'package:got_trivia_game/globals.dart';
import 'package:got_trivia_game/logic/cubit/audio_cubit.dart';
import 'package:got_trivia_game/logic/cubit/number_handler.dart';
import 'package:got_trivia_game/logic/cubit/result_handler.dart';
import 'package:got_trivia_game/main.dart';

import '../../logic/bloc/questions_bloc.dart';
import '../../logic/cubit/stats_cubit.dart';
import '../../utils/clicksound.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<MusicCubit>().state is AudioOn) {
      musicController.pause();
      AudioController(filename: 'result.wav')
        ..play()
        ..onComplete((p0) => musicController.loop());
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 100,
        leading: TextButton.icon(
            onPressed: () {
              playClick(context);

              context.read<NumberHandlerCubit>().reset();
              BlocProvider.of<QuestionsBloc>(context).add(NoQuestions());
              Future.delayed(
                  const Duration(seconds: 1),
                  () => Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false));
            },
            icon: const Icon(Icons.home_outlined),
            label: const Text('Home'),
            style: TextButton.styleFrom(
              primary: grey,
              textStyle: headings.copyWith(fontSize: 18),
            )),
        actions: [
          TextButton.icon(
            onPressed: () {
              playClick(context);

              context.read<NumberHandlerCubit>().reset();
              (Future.delayed(
                  const Duration(seconds: 1),
                  () => SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop')));
            },
            icon: const Icon(Icons.exit_to_app),
            label: const Text('Exit'),
            style: TextButton.styleFrom(
              primary: grey,
              textStyle: headings.copyWith(fontSize: 18),
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
            const Text('RESULT', style: headings),
            const SizedBox(height: 30),
            const ResultWidget(),
            const SizedBox(height: 30),
            Text(context.read<ResultHandlerCubit>().state.message, style: body),
            Flexible(child: Container()),
            TextButton.icon(
              onPressed: () {
                playClick(context);
                context.read<NumberHandlerCubit>().reset();
                BlocProvider.of<QuestionsBloc>(context).add(LoadQuestions());
                Future.delayed(const Duration(seconds: 1),
                    () => Navigator.of(context).pushNamed('/'));
              },
              icon: const Icon(Icons.replay),
              label: const Text('Play again'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: primary,
                textStyle: headings.copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () {
                playClick(context);
                context.read<StatsCubit>().getStats();
                Future.delayed(const Duration(seconds: 1),
                    () => Navigator.of(context).pushNamed('stats'));
              },
              icon: const Icon(Icons.bar_chart_outlined),
              label: const Text('Statistics'),
              style: TextButton.styleFrom(
                primary: primary,
                textStyle: headings.copyWith(fontSize: 18),
              ),
            ),
            Flexible(child: Container())
          ],
        ),
      ),
    );
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
        height: 150,
        width: 150,
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey.shade300,
          color: totalScore >= 5 ? green : red,
          strokeWidth: 10,
          value: context.read<ResultHandlerCubit>().state.correct / 10,
        ),
      ),
      Text(
        '${context.read<ResultHandlerCubit>().state.correct}/10',
        style: result,
      )
    ]);
  }
}
