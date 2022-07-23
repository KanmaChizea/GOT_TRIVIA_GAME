import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/data/audio.dart';
import 'package:got_trivia_game/logic/bloc/questions_bloc.dart';
import 'package:got_trivia_game/logic/cubit/audio_cubit.dart';
import 'package:got_trivia_game/logic/cubit/number_handler.dart';
import 'package:got_trivia_game/logic/cubit/result_handler.dart';
import 'package:got_trivia_game/logic/cubit/stats_cubit.dart';

import '../components/countdown.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';
import 'result.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease))
      ..addStatusListener((status) {});
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NumberHandlerCubit, int>(
        listener: (context, state) {},
        child: Scaffold(
            body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return SlideTransition(
                  position: animation,
                  child: BlocConsumer<NumberHandlerCubit, int>(
                      listener: (context, state) {
                    if (state > 9) {
                      final questions = context.read<QuestionsBloc>().state
                          as QuestionsLoaded;
                      context
                          .read<ResultHandlerCubit>()
                          .processResult(questions.questions);

                      Future.delayed(
                          const Duration(seconds: 1),
                          () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const ResultScreen()),
                              (route) => false));
                    }
                  }, builder: (context, state) {
                    if (state <= 9) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: CountdownTimer(
                            key: ValueKey(state),
                            controller: controller,
                          )),
                          const SizedBox(height: 30),
                          Text(
                            'Question ${state + 1}/10',
                            style: headings,
                          ),
                          const SizedBox(height: 30),
                          Expanded(
                            child: BlocBuilder<QuestionsBloc, QuestionsState>(
                                builder: (context, questionList) {
                              if (questionList is QuestionsLoaded) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '"${questionList.questions[state].question}"',
                                      style: body,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            final question =
                                                questionList.questions[state];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: RadioListTile<String>(
                                                  title: Text(
                                                    question.answers[index],
                                                  ),
                                                  value:
                                                      question.answers[index],
                                                  groupValue:
                                                      question.selectedAnswer,
                                                  onChanged: (String? value) {
                                                    if (value ==
                                                            question
                                                                .correctAnswer &&
                                                        context
                                                            .read<SoundCubit>()
                                                            .state is AudioOn) {
                                                      AudioController(
                                                              filename:
                                                                  'correct.wav')
                                                          .play();
                                                    }
                                                    if (value !=
                                                            question
                                                                .correctAnswer &&
                                                        context
                                                            .read<SoundCubit>()
                                                            .state is AudioOn) {
                                                      AudioController(
                                                          filename: 'wrong.mp3')
                                                        ..play()
                                                        ..setplayback(3.5);
                                                    }
                                                    setState(() {
                                                      question.selectedAnswer =
                                                          value;
                                                    });
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 500),
                                                        () {
                                                      context
                                                          .read<
                                                              NumberHandlerCubit>()
                                                          .nextQuestion();
                                                      controller.reset();
                                                      controller.forward();
                                                    });
                                                  },
                                                  selected: question
                                                          .answers[index] ==
                                                      question.selectedAnswer,
                                                  selectedTileColor: question
                                                              .selectedAnswer ==
                                                          question.correctAnswer
                                                      ? green
                                                      : red,
                                                  activeColor: white,
                                                  tileColor: (question.answers[
                                                                  index] ==
                                                              question
                                                                  .correctAnswer &&
                                                          question.selectedAnswer !=
                                                              null)
                                                      ? green
                                                      : Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        color: white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  )),
                                            );
                                          }),
                                    )
                                  ],
                                );
                              }
                              return Container();
                            }),
                          )
                        ],
                      );
                    }
                    return const Center(child: Text('...preparing results'));
                  }),
                );
              },
            ),
          ),
        )));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
