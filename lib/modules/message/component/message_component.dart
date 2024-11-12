import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../model/message_model.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({
    super.key,
    required this.element,
  });
  final MessageModel element;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: BubbleNormal(
        text: element.text,
        isSender: element.isMe,
        sent: true,
        delivered: true,
        seen: true,
        color: element.isMe ? const Color(0xff18587A) : const Color(0xffE8EEF2),
        tail: true,
        textStyle: TextStyle(
          fontSize: 18,
          color: element.isMe ? Colors.white : blackColor,
        ),
      ),
    );
  }
}
