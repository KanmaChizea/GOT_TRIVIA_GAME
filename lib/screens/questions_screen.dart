import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/components/countdown.dart';
import 'package:got_trivia_game/logic/bloc/questions_bloc.dart';
import 'package:got_trivia_game/logic/cubit/number_handler.dart';
import 'package:got_trivia_game/logic/cubit/result_handler.dart';
import 'package:got_trivia_game/screens/result.dart';
import 'package:got_trivia_game/styles/colors.dart';
import 'package:got_trivia_game/styles/texts.dart';

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
        listener: (context, state) {
          if (state > 9) {
            final questions =
                context.read<QuestionsBloc>().state as QuestionsLoaded;
            context
                .read<ResultHandlerCubit>()
                .processResult(questions.questions);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const ResultScreen()),
                (route) => false);
          }
        },
        child: Scaffold(
            body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return SlideTransition(
                  position: animation,
                  child: BlocBuilder<NumberHandlerCubit, int>(
                      builder: (context, questionNo) {
                    return BlocBuilder<QuestionsBloc, QuestionsState>(
                        builder: (context, state) {
                      if (state is QuestionsLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: CountdownTimer(
                              key: ValueKey(questionNo),
                              controller: controller,
                            )),
                            const SizedBox(height: 30),
                            Text(
                              'Question ${questionNo + 1}/10',
                              style: headings,
                            ),
                            const SizedBox(height: 30),
                            Text(
                              '"${state.questions[questionNo].question}"',
                              style: body,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    final question =
                                        state.questions[questionNo];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: RadioListTile<String>(
                                          title: Text(
                                            question.answers[index],
                                          ),
                                          value: question.answers[index],
                                          groupValue: question.selectedAnswer,
                                          onChanged: (String? value) {
                                            setState(() {
                                              question.selectedAnswer = value;
                                            });
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 500), () {
                                              context
                                                  .read<NumberHandlerCubit>()
                                                  .nextQuestion();
                                              controller.reset();
                                              controller.forward();
                                            });
                                          },
                                          selected: question.answers[index] ==
                                              question.selectedAnswer,
                                          selectedTileColor:
                                              question.selectedAnswer ==
                                                      question.correctAnswer
                                                  ? green
                                                  : red,
                                          activeColor: white,
                                          tileColor: (question.answers[index] ==
                                                      question.correctAnswer &&
                                                  question.selectedAnswer !=
                                                      null)
                                              ? green
                                              : Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            side:
                                                const BorderSide(color: white),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                    );
                                  }),
                            )
                          ],
                        );
                      }
                      return Container();
                    });
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
