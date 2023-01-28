import 'package:flutter/material.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';

class AddMatches extends StatefulWidget {
  const AddMatches({Key? key}) : super(key: key);

  @override
  State<AddMatches> createState() => _AddMatchesState();
}

class _AddMatchesState extends State<AddMatches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Schedule Match", context: context),
      body: Column(
        children: const [
          Text(
            "Select Teams",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
