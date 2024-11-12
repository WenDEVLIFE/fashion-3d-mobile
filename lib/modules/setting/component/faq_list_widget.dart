import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_us/widgets/custom_text.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../model/faq_model.dart';

class FaqListWidget extends StatefulWidget {
  const FaqListWidget({
    super.key,
    required this.faqList,
  });

  final List<FaqModel> faqList;

  @override
  State<FaqListWidget> createState() => _FaqListWidgetState();
}

class _FaqListWidgetState extends State<FaqListWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final tile = widget.faqList[index];
          return Theme(
            data: ThemeData(dividerColor: transparent),
            child: Container(
              margin: Utils.symmetric(h: 16.0).copyWith(bottom: 10.0),
              decoration: BoxDecoration(border: Border.all(color: borderColor)),
              child: ExpansionTile(
                onExpansionChanged: (bool val) {},
                title: CustomText(
                  text: tile.question,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                iconColor: Utils.dynamicPrimaryColor(context),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20.0)
                        .copyWith(top: 0.0),
                    child: Html(data: tile.answer),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: widget.faqList.length,
      ),
    );
  }

  Widget _previousExpansion(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: ((panelIndex, isExpanded) {
        widget.faqList.asMap().forEach((key, value) {
          widget.faqList[key] = widget.faqList[key].copyWith(isExpanded: false);
        });
        widget.faqList[panelIndex] =
            widget.faqList[panelIndex].copyWith(isExpanded: !isExpanded);
        setState(() {});
      }),
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: borderColor.withOpacity(.4),
      elevation: 0,
      children: widget.faqList
          .map(
            (e) => ExpansionPanel(
              isExpanded: e.isExpanded,
              backgroundColor: e.isExpanded
                  ? Utils.dynamicPrimaryColor(context).withOpacity(.1)
                  : null,
              canTapOnHeader: true,
              headerBuilder: (_, bool isExpended) => ListTile(
                title: Text(
                  e.question,
                  maxLines: 1,
                  style: GoogleFonts.jost(fontWeight: FontWeight.w500),
                ),
                // contentPadding: EdgeInsets.zero,
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0)
                        .copyWith(top: 0.0),
                child: Html(data: e.answer),
              ),
            ),
          )
          .toList(),
    );
  }
}
