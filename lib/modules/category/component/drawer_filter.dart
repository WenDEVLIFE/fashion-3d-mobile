import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../controller/cubit/category_cubit.dart';
import '../model/filter_model.dart';

class DrawerFilter extends StatefulWidget {
  const DrawerFilter({super.key});

  @override
  State<DrawerFilter> createState() => _DrawerFilterState();
}

class _DrawerFilterState extends State<DrawerFilter> {
  RangeValues _currentRangeValues = const RangeValues(0, 600);
  final brands = <int>[];
  final variantsItem = <String>[];
  double maxValue = 1.0;
  double minValue = 1000.0;
  double testPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState) {
          return const Center(child: SizedBox());
        } else if (state is CategoryLoadedState) {
          for (var i in state.categoryProducts) {
            if (i.price < minValue) {
              minValue = i.price;
              print('minValue : $minValue');
            }
            if (i.price > maxValue) {
              maxValue = i.price;
              print('maxValue : $maxValue');
            }
          }
          //_currentRangeValues = RangeValues(minValue, maxValue);
          if (state.categoryProducts.isEmpty) {
            return const SizedBox();
          }
          final filterOptions =
              context.read<CategoryCubit>().productCategoriesModel;

          return Drawer(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Scaffold.of(context).closeEndDrawer();
                    },
                    icon: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 2,
                              color: Utils.dynamicPrimaryColor(context))),
                      child: Icon(
                        Icons.clear,
                        color: Utils.dynamicPrimaryColor(context),
                        size: 15,
                      ),
                    ),
                  ),
                  Text(Language.price.capitalizeByWord()),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 4000,
                    // divisions: 5,
                    activeColor: Utils.dynamicPrimaryColor(context),
                    inactiveColor: grayColor,
                    labels: RangeLabels(
                      minValue.round().toString(),
                      maxValue.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                        minValue =
                            double.parse(values.start.round().toString());
                        maxValue = double.parse(values.end.round().toString());
                        print(_currentRangeValues);
                        print("min: $minValue - max: $maxValue");
                      });
                    },
                  ),
                  Text(
                      "${Language.price.capitalizeByWord()} \$$minValue - \$$maxValue"),
                  const SizedBox(height: 10),
                  if (filterOptions.brands.isNotEmpty) ...[
                    Text(
                      Language.brand.capitalizeByWord(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      children: [
                        ...List.generate(
                          filterOptions.brands.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                brands.add(filterOptions.brands[index].id);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(20),
                                color: brands.contains(
                                        filterOptions.brands[index].id)
                                    ? Utils.dynamicPrimaryColor(context)
                                    : Utils.dynamicPrimaryColor(context)
                                        .withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  filterOptions.brands[index].name,
                                  style: GoogleFonts.roboto(
                                      color: brands.contains(
                                              filterOptions.brands[index].id)
                                          ? Colors.white
                                          : blackColor),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                  const SizedBox(height: 10),
                  if (filterOptions.activeVariants.isNotEmpty) ...[
                    ...List.generate(
                        filterOptions.activeVariants.length,
                        (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filterOptions.activeVariants[index].name
                                      .capitalizeByWord(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (filterOptions.activeVariants[index]
                                    .activeVariantsItems.isNotEmpty) ...[
                                  Wrap(
                                    children: [
                                      ...List.generate(
                                        filterOptions.activeVariants[index]
                                            .activeVariantsItems.length,
                                        (i) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              variantsItem.add(filterOptions
                                                  .activeVariants[index]
                                                  .activeVariantsItems[i]
                                                  .name);
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            decoration: BoxDecoration(
                                              //borderRadius: BorderRadius.circular(20),
                                              color: variantsItem.contains(
                                                      filterOptions
                                                          .activeVariants[index]
                                                          .activeVariantsItems[
                                                              i]
                                                          .name)
                                                  ? Utils.dynamicPrimaryColor(
                                                      context)
                                                  : Utils.dynamicPrimaryColor(
                                                          context)
                                                      .withOpacity(0.2),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4.0),
                                              child: Text(
                                                filterOptions
                                                    .activeVariants[index]
                                                    .activeVariantsItems[i]
                                                    .name
                                                    .capitalizeByWord(),
                                                style: GoogleFonts.roboto(
                                                  color: variantsItem.contains(
                                                          filterOptions
                                                              .activeVariants[
                                                                  index]
                                                              .activeVariantsItems[
                                                                  i]
                                                              .name)
                                                      ? Colors.white
                                                      : blackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 10),
                              ],
                            ))
                  ],
                  const SizedBox(height: 20),
                  PrimaryButton(
                      text: Language.findProduct.capitalizeByWord(),
                      onPressed: () {
                        final data = FilterModelDto(
                          brands: brands,
                          variantItems: variantsItem,
                          minPrice: minValue,
                          maxPrice: maxValue,
                        );

                        context.read<CategoryCubit>().getFilterProducts(data);
                        Scaffold.of(context).closeEndDrawer();
                      }),
                ],
              ),
            ),
          );
        } else if (state is CategoryErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return Center(
          child: SizedBox(
            child: Text(Language.somethingWentWrong.capitalizeByWord()),
          ),
        );
      },
    );
  }
}
