import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../logic/cubit/stats_cubit.dart';
import '../styles/texts.dart';

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
