import 'dart:math';

import 'package:flutter/material.dart';

import 'package:got_trivia_game/globals.dart' as globals;
import 'package:got_trivia_game/services/trivia_processing.dart';

class OptionsBuild extends StatefulWidget {
  final String correctAnswer;
  final int questionIndex;

  const OptionsBuild({
    Key? key,
    required this.correctAnswer,
    required this.questionIndex,
  }) : super(key: key);

  @override
  State<OptionsBuild> createState() => _OptionsBuildState();
}

class _OptionsBuildState extends State<OptionsBuild> {
  String? _selectedValue;
  Color correct = Colors.transparent;
  Color wrong = Colors.transparent;
  late String correctOption;
  late int questionIndex;
  late List options;

  List characters = [
    'Jon Snow',
    'Sansa Stark',
    'Eddard "Ned" Stark',
    'Jaime Lannister',
    'Tyrion Lannister',
    'Cersei Lannister',
    'Aerys II Tagaryen',
    'Joffrey Lannister',
    'Daenerys Targaryen',
    'Tywin Lannister',
    'Ramsay Bolton',
    'Arya Stark',
    'Robert Baratheon',
    'Theon Greyjoy',
    'Samwell Tarly',
    'Lord Varys',
    'Bran Stark',
    'Brienne of Tarth',
    'Petyr Baelish',
    'Tormund',
    'Melisandre',
    'Olenna Tyrell',
    'Mance Rayder'
  ];

  List getOptions() {
    final _random = Random();
    late String replacement;

    //select 3 random characters from list
    final options = (characters..shuffle()).take(3).toList();

    //ensure the correct answer in sublist and no item is duplicated
    for (var element in options) {
      if (element == correctOption) {
        options.remove(element);
        do {
          replacement = characters[_random.nextInt(characters.length)];
        } while (options.contains(replacement));
        options.add(replacement);
      }
    }
    //add the correct answer to options list
    options.add(correctOption);
    //shuffle final options
    options.shuffle();
    return options;
  }

  @override
  void initState() {
    correctOption = widget.correctAnswer;
    questionIndex = widget.questionIndex;
    options = getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RadioListTile<String>(
                title: Text(
                  options[index],
                ),
                secondary: (options[index] == correctOption)
                    ? Icon(
                        Icons.done,
                        color: correct,
                      )
                    : Icon(Icons.close, color: wrong),
                value: options[index],
                groupValue: _selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    _selectedValue = value;
                    correct = Colors.green;
                    wrong = Colors.red;
                  });
                  if (options[index] == correctOption) {
                    setState(() {
                      globals.totalScore++;
                    });
                  }

                  Future.delayed(
                      const Duration(seconds: 1),
                      () => TriviaProcessing()
                          .answeredQuestion(questionIndex, context));
                },
                activeColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                )),
          );
        });
  }
}
