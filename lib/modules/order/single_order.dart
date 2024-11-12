import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/please_sign_in_widget.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/single_order_details_component.dart';
import 'controllers/order/order_cubit.dart';
import 'model/order_model.dart';

class SingleOrderDetails extends StatefulWidget {
  const SingleOrderDetails({super.key, this.trackNumber});
  final String? trackNumber;

  @override
  State<SingleOrderDetails> createState() => _SingleOrderDetailsState();
}

class _SingleOrderDetailsState extends State<SingleOrderDetails> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<OrderCubit>().getSingleOrder(widget.trackNumber!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBGColor,
      appBar: RoundedAppBar(
        titleText: Language.singleOrder.capitalizeByWord(),
        bgColor: scaffoldBGColor,
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderStateError) {
            if (state.statusCode == 401) {
              return const PleaseSignInWidget();
            }
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          } else if (state is OrderSingleStateLoaded) {
            return LoadedList(singleOrder: state.singleOrder);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class LoadedList extends StatelessWidget {
  const LoadedList({super.key, required this.singleOrder});
  final OrderModel? singleOrder;

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '';
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: borderColor),
              color: white,
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    Utils.formatDate(singleOrder!.createdAt),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Color(0xff85959E)),
                  ),
                ),
                ...List.generate(
                  singleOrder!.orderProducts.length,
                  (index) => Column(
                    children: [
                      SingleOrderDetailsComponent(
                        orderItem: singleOrder!.orderProducts[index],
                        isOrdered: true,
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                OrderText(
                  title: Language.orderTrackingNumber.capitalizeByWord(),
                  text: singleOrder!.orderId,
                ),
                /*  const SizedBox(height: 8),
                OrderText(
                  title: "Order Id",
                  text: singleOrder!.id.toString(),
                ),*/
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    Utils.orderStatus(singleOrder!.orderStatus.toString()),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: singleOrder!.orderStatus.toString() == '4'
                            ? redColor
                            : greenColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OrderText extends StatelessWidget {
  const OrderText({super.key, this.title, this.text});
  final String? title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "$title:",
        style: const TextStyle(
            fontSize: 16,
            color: iconGreyColor,
            decoration: TextDecoration.underline,
            height: 1),
        children: [
          TextSpan(
            text: ' ${text!}',
            style: const TextStyle(
                color: blackColor,
                fontSize: 16,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
