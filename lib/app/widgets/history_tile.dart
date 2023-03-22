import 'package:datacard/app/data/models/history_model.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../constants/color_constants.dart';

class HistoryTile extends StatelessWidget {
  History history;
  HistoryTile({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorConstants.darkBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorConstants.borderColor,
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                history.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(history.fileType),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(history.transferType),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(history.personName),
                ],
              ),
              Text(
                "on ${DateFormat('dd/MM/yyyy @h:m a').format(history.date)}",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
