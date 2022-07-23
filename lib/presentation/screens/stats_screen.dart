import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/logic/cubit/stats_cubit.dart';
import 'package:intl/intl.dart';

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
              buildStatHeader('Total games played', stats.length),
              buildStatHeader('Average score', average),
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

  Column buildStatHeader(String s, num? t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.orange.shade300),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            t!.toStringAsFixed(2),
            style: body.copyWith(fontSize: 25),
          ),
        ),
        Divider(
          endIndent: MediaQuery.of(context).size.width / 2.5,
        ),
      ],
    );
  }
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

class HighScore extends StatelessWidget {
  const HighScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your high scores',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.orange.shade300),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('S/N', style: tableHeader),
                Text('Score', style: tableHeader),
                Text('Unanswered', style: tableHeader),
                Text('Date', style: tableHeader)
              ],
            )),
        Expanded(
          child: BlocBuilder<StatsCubit, StatsState>(
            builder: (context, state) {
              if (state is StatsLoaded) {
                final data = state.stats;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: (data.length < 10) ? data.length : 10,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${(index + 1).toString()}.',
                                    style: tableHeader.copyWith(fontSize: 15),
                                  ),
                                  Text(
                                    data[index].score.toString(),
                                    style: tableBody,
                                  ),
                                  Text(
                                    data[index].unanswered.toString(),
                                    style: tableBody,
                                  ),
                                  Text(
                                    (DateFormat('dd-MM-yy')
                                        .format(data[index].date)),
                                    style: tableBody,
                                  )
                                ],
                              ),
                              const Divider()
                            ],
                          ),
                        ));
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
