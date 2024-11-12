import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class MessageInputField extends StatefulWidget {
  const MessageInputField({
    super.key,
  });

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    editingController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xff3b5998).withOpacity(0.06),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Row(
        children: [
          Container(
            height: 34,
            width: 34,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: lightningYellowColor,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 22,
            ),
          ),
          Flexible(
            child: TextField(
              focusNode: focusNode,
              textInputAction: TextInputAction.done,
              controller: editingController,
              decoration: inputDecorationTheme.copyWith(
                hintText: 'Write here ...',

                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                suffixIcon: const Icon(Icons.emoji_emotions,
                    color: iconGreyColor, size: 22),
                fillColor: const Color(0xffF6F6F6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
