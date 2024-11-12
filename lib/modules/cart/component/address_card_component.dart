/*import 'package:flutter/material.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../profile/model/address_model.dart';

class AddressCardComponent extends StatelessWidget {
  const AddressCardComponent({
    Key? key,
    required this.addressModel,
    required this.type,
    this.onTap,
    this.pWidth,
    this.selectAddress = 0,
  }) : super(key: key);

  final AddressModel addressModel;
  final VoidCallback? onTap;
  final String type;
  final double? pWidth;
  final int selectAddress;

  @override
  Widget build(BuildContext context) {
    final width = pWidth ?? MediaQuery.of(context).size.width * 0.8;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: width,
      decoration: BoxDecoration(
        color: selectAddress == addressModel.id ? borderColor : white,

        // color: selectAddress == addressModel.id ? Utils.dynamicPrimaryColor(context) : transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
            color:
                selectAddress == addressModel.id ? Utils.dynamicPrimaryColor(context) : borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Icon(Icons.location_on_outlined, color: greenColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        addressModel.name,
                        maxLines: 1,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (pWidth == null)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.addAddressScreen,
                            arguments: addressModel.type,
                          );
                        },
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: paragraphColor.withOpacity(.24),
                          child: const Icon(Icons.edit,
                              size: 16, color: blackColor),
                        ),
                      ),
                  ],
                ),
                Text(
                  addressModel.email,
                  style: const TextStyle(color: iconGreyColor),
                ),
                Text(
                  addressModel.phone,
                  style: const TextStyle(color: iconGreyColor),
                ),
                const SizedBox(height: 6),
                Text(
                  addressModel.type == '1' ? 'Office' : 'Home',
                  style: const TextStyle(
                      color: redColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Text(addressModel.address),
                Text("Zip code : " + addressModel.address),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/modules/cart/model/address_response_model.dart';
import '/utils/language_string.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../profile/model/address_model.dart';

class AddressCardComponent extends StatelessWidget {
  const AddressCardComponent({
    Key? key,
    required this.addressModel,
    required this.type,
    this.onTap,
    this.pWidth,
    this.selectAddress = 0,
    this.isEditButtonShow = true,
  }) : super(key: key);

  final AddressModel addressModel;
  final VoidCallback? onTap;
  final String type;
  final double? pWidth;
  final int selectAddress;
  final bool isEditButtonShow;

  @override
  Widget build(BuildContext context) {
    final width = pWidth ?? MediaQuery.of(context).size.width * 0.8;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      width: width,
      decoration: BoxDecoration(
        color: selectAddress == addressModel.id
            ? greenColor.withOpacity(0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
            color: selectAddress == addressModel.id
                ? deepGreenColor
                : Colors.white),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 10.0),
         child: Icon(Icons.location_on_outlined, color: greenColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        addressModel.name,
                        maxLines: 1,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    isEditButtonShow?const SizedBox(): InkWell(
                      onTap: () async {
                        Navigator.pushNamed(
                          context,
                          RouteNames.addAddressScreen,
                          // arguments: addressModel.type,
                          arguments: addressModel.type,
                        );
                      },
                      child: const CircleAvatar(
                        radius: 13,
                        backgroundColor: greenLight,
                        child: Icon(Icons.edit, size: 16, color: textGreyColor),
                      ),
                    ),

                  ],
                ),
                Text(
                  addressModel.email,
                  style: const TextStyle(color: iconGreyColor),
                ),
                Text(
                  addressModel.phone,
                  style: const TextStyle(color: iconGreyColor),
                ),
                const SizedBox(height: 6),
                Text(
                  addressModel.type == '1' ? 'Office' : "Home",
                  style: const TextStyle(
                      color: redColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Text(addressModel.address),
                Text("${Language.zipCode} : " + addressModel.address),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../profile/model/address_model.dart';

class AddressCardComponent extends StatelessWidget {
  const AddressCardComponent({
    super.key,
    required this.addressModel,
    required this.type,
    this.onTap,
    this.pWidth,
    this.selectAddress = 0,
    this.isEditButtonShow = true,
  });

  final AddressModel addressModel;
  final VoidCallback? onTap;
  final String type;
  final double? pWidth;
  final int selectAddress;
  final bool isEditButtonShow;

  @override
  Widget build(BuildContext context) {
    final width = pWidth ?? MediaQuery.of(context).size.width * 0.8;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      width: width,
      decoration: BoxDecoration(
        color: selectAddress == addressModel.id
            ? Utils.dynamicPrimaryColor(context).withOpacity(0.05)
            : Colors.white,
        //borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
            color: selectAddress == addressModel.id
                ? Utils.dynamicPrimaryColor(context)
                : borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 10.0),
            child: Icon(Icons.location_on_outlined,
                color: Utils.dynamicPrimaryColor(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        addressModel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: headlineTextStyle(16.0),
                      ),
                    ),
                    isEditButtonShow
                        ? const SizedBox()
                        : InkWell(
                            onTap: () async {
                              // Navigator.pushNamed(
                              //   context,
                              //   RouteNames.addAddressScreen,
                              //   arguments: {
                              //     "type": addressModel.type,
                              //     "address_id": addressModel.id
                              //   },
                              // );
                              Navigator.pushNamed(
                                context,
                                RouteNames.editAddressScreen,
                                arguments: {"address_id": addressModel.id},
                              );
                            },
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor:
                                  Utils.dynamicPrimaryColor(context),
                              child: const Icon(Icons.edit,
                                  size: 16, color: white),
                            ),
                          ),
                  ],
                ),
                Text(
                  addressModel.email,
                  style: paragraphTextStyle(14.0),
                ),
                Text(
                  addressModel.phone,
                  style: paragraphTextStyle(14.0),
                ),
                const SizedBox(height: 6),
                Text(
                  addressModel.type == '1' ? 'Office' : "Home",
                  style: headlineTextStyle(14)
                      .copyWith(color: Utils.dynamicPrimaryColor(context)),
                ),
                Text(
                  addressModel.address,
                  style: paragraphTextStyle(14.0),
                ),
                //Text("${Language.zipCode} : ${addressModel.address}",style: paragraphTextStyle(14.0),),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
