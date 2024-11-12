import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../../utils/constants.dart';
import '../../dummy_data/all_dummy_data.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/message_component.dart';
import 'component/message_input_field.dart';
import 'model/message_model.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        bgColor: Colors.white,
        textColor: blackColor,
        titleText: 'Back to Home',
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<MessageModel, DateTime>(
              padding: const EdgeInsets.all(8),
              elements: chatMessageList,
              groupBy: (element) => DateTime(
                element.dateTime.year,
                element.dateTime.month,
                element.dateTime.day,
              ),
              groupSeparatorBuilder: (DateTime groupByValue) =>
                  _MessageSeparator(groupByValue: groupByValue),

              itemBuilder: (context, MessageModel element) =>
                  MessageComponent(element: element),

              itemComparator: (item1, item2) =>
                  item1.dateTime.compareTo(item2.dateTime), // optional
              useStickyGroupSeparators: true, // optional
              floatingHeader: true, // optional
              order: GroupedListOrder.ASC, // optional
            ),
          ),
          const MessageInputField(),
        ],
      ),
    );
  }
}

class _MessageSeparator extends StatelessWidget {
  const _MessageSeparator({
    required this.groupByValue,
  });
  final DateTime groupByValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: DateChip(date: groupByValue, color: iconGreyColor),
      ),
    );
  }
}
