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
  int? selected;

  List getOptions() {
    final _random = Random();
    late String replacement;

    //select 3 random characters from list
    final options = (globals.globalCharacterList..shuffle()).take(3).toList();

    //ensure the correct answer in sublist and no item is duplicated
    for (var element in options) {
      if (element == correctOption) {
        options.remove(element);
        do {
          replacement = globals.globalCharacterList[
              _random.nextInt(globals.globalCharacterList.length)];
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
                    : (selected == index)
                        ? Icon(Icons.close, color: wrong)
                        : null,
                value: options[index],
                selectedTileColor: (options[index] == correctOption)
                    ? const Color(0xff7cfc00)
                    : const Color.fromARGB(255, 255, 9, 0),
                groupValue: _selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selected = index;
                    _selectedValue = value;
                    correct = const Color(0xff7cfc00);
                    wrong = const Color.fromARGB(255, 255, 9, 0);
                  });
                  if (options[index] == correctOption) {
                    setState(() {
                      globals.totalScore++;
                    });
                  }

                  Future.delayed(
                      const Duration(seconds: 1),
                      () => TriviaProcessing()
                          .answeredQuestion(questionIndex, context, true));
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
