import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/logic/cubit/stats_cubit.dart';
import 'package:intl/intl.dart';

import '../components/highscore.dart';
import '../components/stats_header.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your High Scores'),
        titleTextStyle: headings.copyWith(color: white),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<StatsCubit, StatsState>(builder: (context, state) {
        if (state is StatsLoaded) {
          final stats = state.stats;
          final average = stats
                  .map((e) => e.score)
                  .reduce((value, element) => value + element) /
              stats.length;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              BuildStatHeader(
                  headerText: 'Total games played', value: stats.length),
              BuildStatHeader(headerText: 'Average score', value: average),
              const SizedBox(
                height: 20,
              ),
              const Expanded(child: HighScore()),
              TextButton.icon(
                onPressed: () async {
                  final confirm = await confirmDelete(context);
                  if (confirm) {
                    context.read<StatsCubit>().deleteStats();
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  size: 26,
                ),
                label: const Text('Clear All'),
                style: TextButton.styleFrom(
                    primary: Colors.orange.shade300,
                    textStyle: const TextStyle(fontSize: 20)),
              )
            ]),
          );
        } else {
          return const Center(
            child: Text(
              'No statistics available',
              style: body,
            ),
          );
        }
      }),
    );
  }

  Future<bool> confirmDelete(BuildContext context) async {
    return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  content: const Text(
                      'Are you sure you want to clear your statistics?'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Delete'))
                  ],
                )) ??
        false;
  }
}
