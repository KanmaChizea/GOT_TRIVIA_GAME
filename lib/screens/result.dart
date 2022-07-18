import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:got_trivia_game/globals.dart';
import 'package:got_trivia_game/logic/cubit/result_handler.dart';
import 'package:got_trivia_game/styles/colors.dart';
import 'package:got_trivia_game/styles/texts.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 100,
        leading: TextButton.icon(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false),
            icon: const Icon(Icons.home_outlined),
            label: const Text('Home'),
            style: TextButton.styleFrom(
              primary: grey,
              textStyle: headings.copyWith(fontSize: 18),
            )),
        actions: [
          TextButton.icon(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
              onPressed: () {},
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
              onPressed: () {},
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
