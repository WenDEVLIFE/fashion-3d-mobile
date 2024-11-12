import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ToggleButtonComponent extends StatefulWidget {
  const ToggleButtonComponent({
    super.key,
    required this.onChange,
    required this.textList,
    this.initialLabelIndex = 0,
  });

  final void Function(int index) onChange;
  final int initialLabelIndex;
  final List<String> textList;

  @override
  State<ToggleButtonComponent> createState() => _ToggleButtonComponentState();
}

class _ToggleButtonComponentState extends State<ToggleButtonComponent> {
  late int initialLabelIndex;
  late List<String> textList;

  @override
  void initState() {
    super.initState();
    initialLabelIndex = widget.initialLabelIndex;
    textList = widget.textList;
  }

  List<Widget> getBtns() {
    final childList = <Widget>[];

    textList.asMap().forEach(
      (key, value) {
        childList.add(_buildSingleBtn(key, value));
      },
    );
    return childList;
  }

  Widget _buildSingleBtn(int key, String value) {
    return Flexible(
      flex: 2,
      child: InkWell(
        onTap: () => setState(() {
          initialLabelIndex = key;
          widget.onChange(initialLabelIndex);
        }),
        child: AnimatedContainer(
          duration: kDuration,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          // padding: const EdgeInsets.symmetric(vertical: 8).copyWith(bottom: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: initialLabelIndex == key
                ? Utils.dynamicPrimaryColor(context)
                : transparent,
            //borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: Utils.only(bottom: 6.0),
            child: Text(
              value,
              style: paragraphTextStyle(14.0).copyWith(
                  color: initialLabelIndex != key
                      ? const Color(0xFF6E6D79)
                      : white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: getBtns(),
        ),
      ),
    );
  }
}
