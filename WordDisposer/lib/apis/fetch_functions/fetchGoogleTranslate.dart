import 'package:WordDisposer/apis/data_models/googleTranslate.dart';
import 'package:http/http.dart' as http;
import 'package:WordDisposer/apis/data_models/linguee.dart';
import 'dart:convert';

Future<GoogleTranslate> fetchGoogleTranslate(String word,
    {String src = "en", String dst = "pt"}) async {
  Map<String, String> headers = {
    "x-rapidapi-host": "google-translate1.p.rapidapi.com",
    "x-rapidapi-key": "8b6b2cfc42msha80c77273582d24p1179cdjsn7683eb43a839",
    "accept-encoding": "application/gzip",
    "content-type": "application/x-www-form-urlencoded",
    "useQueryString": "true"
  };

  Map<String, String> body = {"source": src, "q": word, "target": dst};
  final response = await http.post(
      'https://google-translate1.p.rapidapi.com/language/translate/v2',
      headers: headers,
      body: body,
      encoding: Encoding.getByName("UTF-8"));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return GoogleTranslate.fromJson(json.decode(response.body));
  } else if (response.statusCode == 400) {
    // Empty query - do nothing
    throw Exception('Error - empty query');
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error ${response.statusCode}');
  }
}

List<String> googleTranslateResults(GoogleTranslate data) {
  List<String> translations = new List<String>();
  if (data.data != null) {
    if (data.data.translations != null) {
      data.data.translations.forEach((element) {
        translations.add(element.translatedText);
      });
    }
  }
  return translations;
}
