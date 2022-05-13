import 'package:http/http.dart' as http;
import 'dart:convert';

class TriviaApi {
  Future fetchData() async {
    Uri url = Uri.parse(
        'https://gameofthrones-quotes-api.herokuapp.com/api/v1/quotes');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }
}
