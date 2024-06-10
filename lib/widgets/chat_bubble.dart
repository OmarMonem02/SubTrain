import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Color color;
  final String message;
  final TextStyle fontstyle;
  const ChatBubble(
      {super.key,
      required this.color,
      required this.message,
      required this.fontstyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
      child: Text(
        message,
        style: fontstyle,
      ),
    );
  }
}
