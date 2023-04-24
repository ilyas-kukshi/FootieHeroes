import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/tournament/scoring/commentary_module/commentary_model.dart';
import 'package:http/http.dart' as http;

class KeyToSentencesService {
  Future<List<String>> getConmmentary(List<String> keywords) async {
    String keys = keywords.join(' ');
    keywords = keys.split(' ');
    Set<String> uniqueKeys = Set<String>.from(keywords);

    keys = uniqueKeys.join(' ');
    var url = Uri.parse('http://footirheroes.pythonanywhere.com');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"keywords": keys}),
    );

    List<dynamic> sentences = json.decode(response.body)["sentences"];
    List<String> finalSentences = sentences.map((e) => e.toString()).toList();

    return finalSentences;
  }

  updateCommentary(int minute, String finalCommentary, String matchId) async {
    CommentaryModel cm = CommentaryModel(
      timestamp: DateTime.now(),
      commentary: finalCommentary,
      minute: minute,
    );

    await FirebaseFirestore.instance
        .collection("Matches")
        .doc(matchId)
        .collection("Commentary")
        .add(cm.toJson())
        .then((value) {
      Fluttertoast.showToast(msg: "Commentary Added")
          .onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
        return null;
      });
    });
  }
}
