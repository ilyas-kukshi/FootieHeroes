import 'package:flutter/material.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/tournament/scoring/commentary_module/key_to_sentences_service.dart';

// ignore: must_be_immutable
class CommentaryWidget extends StatefulWidget {
  ValueChanged<String> currentCommentary;
  CommentaryWidget({super.key, required this.currentCommentary});

  @override
  State<CommentaryWidget> createState() => _CommentaryWidgetState();
}

class _CommentaryWidgetState extends State<CommentaryWidget> {
  TextEditingController commentaryController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  List<String> _filteredTags = [];
  List<String> selectedKeywords = [];
  List<String> generatedSentences = [];
  int generatedSentencesIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Generate Commentary",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        selectedKeywords.isNotEmpty
            ? Wrap(
                children: selectedKeywords.map((key) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: AppThemeShared.primaryColor, width: 2)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(key),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedKeywords.remove(key);
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: AppThemeShared.primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            : const Offstage(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            onChanged: _onTextChanged,
            decoration: const InputDecoration(
              hintText: 'Enter a tag',
            ),
          ),
        ),
        if (_filteredTags.isNotEmpty)
          Dialog(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredTags.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_filteredTags[index]),
                  onTap: () {
                    selectedKeywords.add(_filteredTags[index]);
                    _filteredTags.clear();
                    _controller.clear();
                    setState(() {});
                    // Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        selectedKeywords.length >= 2
            ? Center(
                child: AppThemeShared.sharedButton(
                  context: context,
                  height: 45,
                  width: 200,
                  buttonText: "Get Commentary",
                  onTap: () async {
                    generatedSentences = await KeyToSentencesService()
                        .getConmmentary(selectedKeywords);

                    commentaryController.text = generatedSentences[0];
                    widget.currentCommentary(commentaryController.text);
                    setState(() {});
                  },
                ),
              )
            : const Offstage(),
        const SizedBox(height: 10),
        generatedSentences.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    generatedSentencesIndex > 0
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                generatedSentencesIndex--;
                                commentaryController.text =
                                    generatedSentences[generatedSentencesIndex];
                              });
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppThemeShared.primaryColor,
                            ),
                          )
                        : const Offstage(),
                    Flexible(
                        child: AppThemeShared.textFormField(
                      context: context,
                      controller: commentaryController,
                      onChanged: (p0) {
                        widget.currentCommentary(p0);
                      },
                    )),
                    generatedSentencesIndex < generatedSentences.length
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                generatedSentencesIndex++;
                                commentaryController.text =
                                    generatedSentences[generatedSentencesIndex];
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppThemeShared.primaryColor,
                            ),
                          )
                        : const Offstage(),
                  ],
                ),
              )
            : const Offstage(),
      ],
    );
  }

  void _onTextChanged(String value) {
    setState(() {
      _filteredTags = [
        "low cross",
        "In swinging cross",
        "Out swinging cross",
        'High cross',
        "Chip cross",
        "Cut back cros",
        "Diagonal cross",
        "save",
        "shot",
        "scored",
        "near post",
        "goalkeeper",
        "card",
        "yellow",
        "half volley",
        "edge of box",
        "late challenge",
        "throughball",
        "footwork",
        "fingertips save",
        "long range",
        "top corner",
        "bottom corner",
        "placed",
        "sliding tackle",
        "wins ball",
        "two footed challenge",
        "sent off"
      ]
          .where(
              (tag) => tag.toLowerCase().contains(value.toLowerCase().trim()))
          .toList();
    });
  }
}
