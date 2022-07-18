import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/logic/bloc/questions_bloc.dart';
import 'package:got_trivia_game/logic/cubit/number_handler.dart';
import 'package:got_trivia_game/screens/home.dart';
import 'package:got_trivia_game/screens/questions_screen.dart';
import 'package:got_trivia_game/styles/colors.dart';

import 'logic/cubit/result_handler.dart';
import 'screens/result.dart';
import 'screens/statistics.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuestionsBloc()),
        BlocProvider(create: (context) => NumberHandlerCubit()),
        BlocProvider(create: (context) => ResultHandlerCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark, scaffoldBackgroundColor: background),
        routes: {
          '/': (context) => const Home(),
          'questions': (context) => const QuestionScreen(),
          'result': (context) => const ResultScreen(),
          'stats': (context) => const StatisticsScreen(),
        },
        home: const Home(),
      ),
    );
  }
}
