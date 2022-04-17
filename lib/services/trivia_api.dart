import 'package:http/http.dart' as http;
import 'dart:convert';

class TriviaApi {
  Future fetchData() async {
    Uri url =
        Uri.parse('https://game-of-thrones-quotes.herokuapp.com/v1/random/10');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }
}
