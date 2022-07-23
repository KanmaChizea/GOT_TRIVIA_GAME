import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/data/audio.dart';
import 'package:got_trivia_game/data/database/stat_db.dart';
import 'package:got_trivia_game/logic/bloc/questions_bloc.dart';
import 'package:got_trivia_game/logic/cubit/audio_cubit.dart';
import 'package:got_trivia_game/logic/cubit/number_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'logic/cubit/result_handler.dart';
import 'logic/cubit/stats_cubit.dart';
import 'presentation/screens/home.dart';
import 'presentation/screens/questions_screen.dart';
import 'presentation/screens/result.dart';
import 'presentation/screens/stats_screen.dart';
import 'presentation/styles/colors.dart';

//late MyDatabase database;
final AudioController musicController = AudioController(filename: 'music.mp3');
final AudioController clickController = AudioController(filename: 'click.wav');

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StatsDataAdapter());
  await Hive.openBox('audio');
  await Hive.openBox<StatsData>('stats');

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
          BlocProvider(create: (context) => StatsCubit()),
          BlocProvider(create: (context) {
            return MusicCubit()..initState();
          }),
          BlocProvider(create: (context) => SoundCubit()..initState()),
        ],
        child: BlocListener<MusicCubit, AudioState>(
          listener: (context, state) {
            if (state is AudioOn) {
              musicController.loop();
            }
            if (state is AudioOff) {
              musicController.stop();
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: background),
            routes: {
              'questions': (context) => const QuestionScreen(),
              'result': (context) => const ResultScreen(),
              'stats': (context) => const StatsScreen(),
            },
            home: const Home(),
          ),
        ));
  }
}
