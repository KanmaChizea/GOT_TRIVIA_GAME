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
        title: const Text('Your High Scores'),
        titleTextStyle: headings().copyWith(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children: [
          buildStatHeader('Total games played'),
          buildStatHeader('Average scores'),
          buildStatHeader('Your high scores'),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => Column(children: []),
          ),
        ]),
      ),
    );
  }

  Column buildStatHeader(String s) {
    return Column(
      children: [
        Text(
          s,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.blueGrey),
        ),
        Divider(
          endIndent: MediaQuery.of(context).size.width / 2.5,
        ),
      ],
    );
  }
}
