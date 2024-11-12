import 'package:flutter/material.dart';
import 'package:shop_us/widgets/capitalized_word.dart';

import '/modules/cart/model/shipping_response_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';

class ShippingMethodList extends StatefulWidget {
  const ShippingMethodList({
    super.key,
    required this.shippingMethods,
    required this.onChange,
  });
  final List<ShippingResponseModel> shippingMethods;

  final ValueChanged<int> onChange;

  @override
  State<ShippingMethodList> createState() => _ShippingMethodListState();
}

class _ShippingMethodListState extends State<ShippingMethodList> {
  ShippingResponseModel? shippingMethodModel;

  @override
  void initState() {
    super.initState();
    if (widget.shippingMethods.isNotEmpty) {
      shippingMethodModel = widget.shippingMethods.first;

      widget.onChange(shippingMethodModel!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            Language.shippingCost.capitalizeByWord(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          ...widget.shippingMethods.map(
            (e) {
              final isSelected = e == shippingMethodModel;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                        color: isSelected
                            ? Utils.dynamicPrimaryColor(context)
                            : borderColor)),
                child: ListTile(
                  onTap: () {
                    shippingMethodModel = e;
                    widget.onChange(e.id);
                    setState(() {});
                  },
                  horizontalTitleGap: 0,
                  title: Text(
                      "${Language.fees.capitalizeByWord()}: ${e.shippingFee}"),
                  subtitle: Text(e.shippingRule),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
