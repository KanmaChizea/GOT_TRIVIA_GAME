import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/questions_bloc.dart';
import 'loading.dart';
import 'menu.dart';
import 'no_network.dart';
import 'questions_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<QuestionsBloc, QuestionsState>(
            builder: ((context, state) {
          if (state is QuestionsInitial) {
            return const MainMenu();
          }
          if (state is QuestionsLoading) {
            return const LoadingScreen();
          }
          if (state is QuestionsLoaded) {
            return const QuestionScreen();
          }
          if (state is QuestionsFailed) {
            return const NoNetwork();
          }
          return Container();
        })),
      ),
    );
  }
}
