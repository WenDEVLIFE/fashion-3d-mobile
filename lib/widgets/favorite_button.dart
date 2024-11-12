import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/profile/profile_offer/controllers/wish_list/wish_list_cubit.dart';
import '../modules/profile/profile_offer/model/wish_list_model.dart';
import '../utils/language_string.dart';
import '../utils/utils.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.productId,
    this.isBg = true,
  });
  final int productId;
  final bool isBg;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final double height = 30;

  late Set<WishListModel> wishItem;

  @override
  void initState() {
    super.initState();
    wishItem = <WishListModel>{};
    loadWishItems();
  }

  bool isFav = false;

  loadWishItems() {
    final wishListItems = context.read<WishListCubit>().wishList;
    final i = wishListItems
        .where((element) => element.id == widget.productId)
        .toSet();
    debugPrint("Wishlist item: $i");
    if (i.isNotEmpty) {
      setState(() {
        isFav = true;
        wishItem = i;
        print('Ittttt $i');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool isFav = false;
    return BlocListener<WishListCubit, WishListState>(
        listener: (context, state) {
      if (state is WishListStateLoading) {
        //Utils.loadingDialog(context);
      } else {
        //Utils.closeDialog(context);
        if (state is WishListStateError) {
          Utils.errorSnackBar(context, state.message);
        } else if (state is WishListStateSuccess) {
          Utils.showSnackBar(context, state.message);
        } else if (state is WishListStateLoaded) {
          wishItem = state.productList
              .where((element) => element.id == widget.productId)
              .toSet();
        }
      }
    }, child: StatefulBuilder(
      builder: (context, StateSetter setState) {
        return InkWell(
          onTap: () async {
            if (isFav) {
              if (wishItem.isNotEmpty) {
                final r = await context
                    .read<WishListCubit>()
                    .removeWishList(wishItem.first);
                r.fold(
                  (failure) {
                    Utils.showSnackBar(context, failure.message);
                  },
                  (success) {
                    Utils.showSnackBar(context, success);
                  },
                );
              } else {
                Utils.showSnackBar(context, Language.somethingWentWrong);
              }
            } else {
              context.read<WishListCubit>().addWishList(widget.productId);
            }
            setState(() => isFav = !isFav);
          },
          child: Container(
            height: height,
            width: height,
            alignment: Alignment.center,
            // margin: const EdgeInsets.only(top: 10.0, left: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Utils.dynamicPrimaryColor(context),
              ),
            ),
          ),
        );
      },
    ));
  }

  BlocConsumer<WishListCubit, WishListState> buildBlocConsumer() {
    return BlocConsumer<WishListCubit, WishListState>(
      listener: (context, state) {
        if (state is WishListStateLoading) {
          //Utils.loadingDialog(context);
        } else {
          //Utils.closeDialog(context);
          if (state is WishListStateError) {
            Utils.errorSnackBar(context, state.message);
          } else if (state is WishListStateSuccess) {
            Utils.showSnackBar(context, state.message);
          }
        }
      },
      builder: (context, state) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          if (state is WishListStateLoaded) {
            wishItem = state.productList
                .where((element) => element.id == widget.productId)
                .toSet();
          }
          return InkWell(
            onTap: () async {
              if (isFav) {
                if (wishItem.isNotEmpty) {
                  final r = await context
                      .read<WishListCubit>()
                      .removeWishList(wishItem.first);
                  // setState(() {});
                  // print("r: $r");
                  r.fold(
                    (failure) {
                      Utils.showSnackBar(context, failure.message);
                    },
                    (success) {
                      Utils.showSnackBar(context, success);
                    },
                  );
                } else {
                  Utils.showSnackBar(context, "Something went wrong");
                }
              } else {
                context.read<WishListCubit>().addWishList(widget.productId);
              }
              setState(() => isFav = !isFav);
            },
            child: Container(
              height: height,
              width: height,
              alignment: Alignment.center,
              // margin: const EdgeInsets.only(top: 10.0, left: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Utils.dynamicPrimaryColor(context),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

Widget favorite(BuildContext context) {
  return Container(
    height: 40.0,
    width: 40.0,
    margin: const EdgeInsets.only(top: 10.0, left: 10.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Icon(Icons.favorite_outline_sharp,
        color: Utils.dynamicPrimaryColor(context), size: 28.0),
  );
}
