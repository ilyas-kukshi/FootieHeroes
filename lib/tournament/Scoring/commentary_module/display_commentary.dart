import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/scoring/commentary_module/commentary_model.dart';

class DisplayCommentary extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  DisplayCommentary({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DisplayCommentaryState();
}

class _DisplayCommentaryState extends ConsumerState<DisplayCommentary> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Matches")
          .doc(widget.matchModel.id)
          .collection("Commentary")
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                CommentaryModel model =
                    CommentaryModel.fromDocument(snapshot.data.docs[index]);
                return Column(
                  children: [
                    IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("${model.minute}'"),
                            const SizedBox(width: 8),
                            const VerticalDivider(
                              thickness: 1.5,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                model.commentary,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Divider(
                        color: Colors.black,
                        thickness: 1.5,
                      ),
                    )
                  ],
                );
              },
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
