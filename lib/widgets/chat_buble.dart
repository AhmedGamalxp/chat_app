import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/massages_model.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.massage});
  final MassageModel massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          color: kPrimerColor,
        ),
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
