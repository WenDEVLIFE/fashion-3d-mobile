import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ToggleButtonScrollComponent extends StatefulWidget {
  const ToggleButtonScrollComponent({
    super.key,
    required this.onChange,
    required this.textList,
    this.initialLabelIndex = 0,
  });

  final void Function(int index) onChange;
  final int initialLabelIndex;
  final List<String> textList;

  @override
  State<ToggleButtonScrollComponent> createState() =>
      _ToggleButtonScrollComponentState();
}

class _ToggleButtonScrollComponentState
    extends State<ToggleButtonScrollComponent> {
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
    return InkWell(
      onTap: () => setState(() {
        initialLabelIndex = key;
        widget.onChange(initialLabelIndex);
      }),
      child: AnimatedContainer(
        duration: kDuration,
        padding:
            const EdgeInsets.symmetric(horizontal: 14).copyWith(bottom: 5.0),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: textList.length - 1 == key ? 0.0 : 10.0),
        decoration: BoxDecoration(
          color: initialLabelIndex == key
              ? Utils.dynamicPrimaryColor(context)
              : Utils.dynamicPrimaryColor(context).withOpacity(0.1),
          // borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: initialLabelIndex != key
                ? Utils.dynamicPrimaryColor(context)
                : white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: getBtns(),
        ),
      ),
    );
  }
}
