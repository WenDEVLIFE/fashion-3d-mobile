import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/widgets/capitalized_word.dart';
import '../../utils/language_string.dart';
import '../../utils/utils.dart';
import '../../widgets/field_error_text.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import '../cart/controllers/checkout/checkout_cubit.dart';
import 'controllers/bank/bank_cubit.dart';

class BankPaymentScreen extends StatefulWidget {
  const BankPaymentScreen({super.key, required this.mapBody});
  final Map<String, dynamic> mapBody;

  @override
  State<BankPaymentScreen> createState() => _BankPaymentScreenState();
}

class _BankPaymentScreenState extends State<BankPaymentScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bankInfo = context.read<CheckoutCubit>().checkoutResponseModel;
    print(bankInfo!.bankStatus!.accountInfo);
    return Scaffold(
      appBar: RoundedAppBar(titleText: Language.bankPayment.capitalizeByWord()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            BlocBuilder<BankCubit, BankState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      maxLines: 10,
                      controller: textController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Utils.dynamicPrimaryColor(context))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Utils.dynamicPrimaryColor(context))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Utils.dynamicPrimaryColor(context))),
                        hintText: bankInfo.bankStatus!.accountInfo,
                      ),
                    ),
                    if (state is BankPaymentFormError) ...[
                      if (state.errors.tnxInfo.isNotEmpty)
                        ErrorText(text: state.errors.tnxInfo.first),
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onPressed: () {
                final Map<String, String> body = {
                  'agree_terms_condition': '1',
                  'shipping_address_id': widget.mapBody['shipping_address_id'],
                  'billing_address_id': widget.mapBody['billing_address_id'],
                  'shipping_method_id': widget.mapBody['shipping_method_id'],
                  'tnx_info': textController.text
                };
                debugPrint(body.toString());
                context.read<BankCubit>().makeBankPayment(body);
              },
              text: "Continue",
            )
          ],
        ),
      ),
    );
  }
}
