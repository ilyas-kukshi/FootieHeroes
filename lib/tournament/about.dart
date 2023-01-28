import 'package:flutter/material.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:intl/intl.dart';

class About extends StatefulWidget {
  AddTournamentModel tournamentModel;
  About({Key? key, required this.tournamentModel}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name:"),
                    Text(
                      widget.tournamentModel.name,
                      style: const TextStyle(
                        letterSpacing: 1.5,
                      ),
                      ),
                    const SizedBox(height: 20),
                    const Text("Date:"),
                    Text( 
                      "${DateFormat.yMMMMd().format(widget.tournamentModel.startDate)}  To  ${DateFormat.yMMMMd().format(widget.tournamentModel.endDate)}",
                      style: const TextStyle(
                        letterSpacing: 1.5,
                      ),
                    ),
                  ]),
            ),
          ),
        )
      ],
    );
  }
}
