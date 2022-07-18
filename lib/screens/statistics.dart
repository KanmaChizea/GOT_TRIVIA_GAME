import 'package:flutter/material.dart';
import 'package:got_trivia_game/services/database/database.dart';
import 'package:got_trivia_game/styles/texts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late MyDatabase database;

  Future _getScores() async {
    return await database.getScores();
  }

  @override
  Widget build(BuildContext context) {
    database = Provider.of<MyDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your High Scores'),
        titleTextStyle: headings.copyWith(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
          future: _getScores(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final data = snapshot.data as List<Statistic>;
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No Statistics available'),
                    );
                  }
                  return screenBody(data);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Sorry, an error occured!',
                      style: body,
                    ),
                  );
                }
                break;
              default:
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }),
    );
  }

  Padding screenBody(List<Statistic> data) {
    var average =
        data.map((m) => m.score).reduce((a, b) => a + b) / data.length;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        buildStatHeader('Total games played', data.length),
        buildStatHeader('Average score', average),
        Expanded(child: buildHighScore(data)),
        const SizedBox(
          height: 20,
        ),
        TextButton.icon(
          onPressed: () async {
            final confirm = await confirmDelete();
            if (confirm) {
              database.deleteStats();
              setState(() {});
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

  buildHighScore(List<Statistic> data) {
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
              children: [
                Text(
                  'S/N',
                  style: tableHeader,
                ),
                Text(
                  'Score',
                  style: tableHeader,
                ),
                Text(
                  'Unanswered',
                  style: tableHeader,
                ),
                Text(
                  'Date',
                  style: tableHeader,
                )
              ],
            )),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: (data.length < 10) ? data.length : 10,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              (DateFormat('dd-MM-yy').format(data[index].date)),
                              style: tableBody,
                            )
                          ],
                        ),
                        const Divider()
                      ],
                    ),
                  )),
        ),
      ],
    );
  }

  Future<bool> confirmDelete() async {
    return await showDialog(
            context: context,
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
