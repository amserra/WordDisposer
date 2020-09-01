import 'package:http/http.dart' as http;
import 'package:WordDisposer/apis/data_models/linguee.dart';
import 'dart:convert';

Future<Linguee> fetchLinguee(String word,
    {String src = "en", String dst = "pt"}) async {
  final response = await http
      .get('https://linguee-api.herokuapp.com/api?q=$word&src=$src&dst=$dst');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Linguee.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else if (response.statusCode == 400) {
    // Empty query - do nothing
    throw Exception('${json.decode(response.body)["message"]}');
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('${json.decode(response.body)["message"]}');
  }
}

List<String> lingueeResults(Linguee data) {
  List<String> translations = new List<String>();
  if (data.exactMatches != null) {
    data.exactMatches.forEach((element) {
      element.translations.forEach((translation) {
        translations.add(translation.text);
      });
    });
    if (translations.length > 15) translations = translations.sublist(0, 16);
  } else {
    if (data.inexactMatches != null) {
      data.inexactMatches.forEach((element) {
        element.translations.forEach((translation) {
          translations.add(translation.text);
        });
      });
      if (translations.length > 15) translations = translations.sublist(0, 16);
    } else {
      // nada
    }
  }
  return translations;
}
