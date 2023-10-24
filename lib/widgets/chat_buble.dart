import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../models/massages_model.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.massage,
  });
  final MassageModel massage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          color: kPrimerColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 5, top: 10),
              child: Text(
                massage.massage,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
              child: Text(
                DateFormat.Hm().format(massage.sentAt.toDate()).toString(),
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({super.key, required this.massage});
  final MassageModel massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            color: Color(0xff006D84)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            massage.massage,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
