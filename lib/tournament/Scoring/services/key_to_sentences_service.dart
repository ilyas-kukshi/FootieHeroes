import 'dart:convert';

import 'package:http/http.dart' as http;

class KeyToSentencesService {
  Future<List<dynamic>> getConmmentary(List<String> keywords) async {
    String keys = keywords.join(' ');
    keywords = keys.split(' ');
    Set<String> uniqueKeys = Set<String>.from(keywords);

    keys = uniqueKeys.join(' ');
    var url = Uri.parse('http://10.0.2.2:7777/');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"keywords": keys}),
    );
    // print(response.body);
    List<dynamic> sentences = jsonDecode(response.body)["sentences"];

    return sentences;
  }
}
