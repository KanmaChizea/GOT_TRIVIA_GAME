import 'package:got_trivia_game/data/exceptions.dart';
import 'package:got_trivia_game/data/models/questions.dart';
import 'package:got_trivia_game/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fetchData() async {
  Uri url =
      Uri.parse('https://gameofthrones-quotes-api.herokuapp.com/api/v1/quotes');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw CouldNotFetchQuestions();
  }
}

Future<List<Questions>> getQuestions() async {
  try {
    final jsondata = await fetchData();
    final data = jsondata["data"] as List;
    List<Questions> triviaQuestions = [];

    data.shuffle();

    for (int i = 0; i < 10; i++) {
      List<String> options = [data[i]['character']];
      do {
        globals.globalCharacterList.shuffle();
        if (globals.globalCharacterList[0] != data[i]['character'] &&
            !options.contains(globals.globalCharacterList[0])) {
          options.add(globals.globalCharacterList[0]);
        }
      } while (options.length != 4);
      options.shuffle();
      triviaQuestions.add(Questions(
          question: data[i]['quote'],
          answers: options,
          correctAnswer: data[i]['character']));
    }
    return triviaQuestions;
  } catch (e) {
    rethrow;
  }
}
