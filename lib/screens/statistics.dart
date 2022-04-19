import 'package:flutter/material.dart';
import 'package:got_trivia_game/styles/texts.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Statistics'),
        titleTextStyle: headings().copyWith(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStatisticsHeader('Your Highscore'),
            Container(
                margin: const EdgeInsets.all(15),
                height: 120,
                decoration: const ShapeDecoration(
                    shape: CircleBorder(
                        side: BorderSide(
                  color: Colors.white,
                  width: 1.5,
                ))),
                child: Center(
                    child: Text('10', style: body().copyWith(fontSize: 50)))),
            buildStatisticsHeader('History')
          ],
        ),
      ),
    );
  }

  buildStatisticsHeader(String s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s,
          style: statisticsHeaders(),
        ),
        Divider(
          endIndent: MediaQuery.of(context).size.width / 2,
          height: 15,
          thickness: 1.2,
          color: Colors.grey,
        )
      ],
    );
  }
}
