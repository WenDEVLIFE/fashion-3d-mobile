import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/utils/constants.dart';
import '/widgets/capitalized_word.dart';
import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/language_string.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/rounded_app_bar.dart';
import 'controller/cubit/category_cubit.dart';
import 'model/category_model.dart';

class AllCategoryListScreen extends StatelessWidget {
  const AllCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryCubit>().getCategoryList();
    final receivedValue =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final appBarName = receivedValue['app_bar'] as String;
    return Scaffold(
      appBar: RoundedAppBar(
        titleText: appBarName,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryListLoadedState ||
              state is CategoryLoadedState) {
            final categories = context.read<CategoryCubit>().categoryList;
            if (categories.isEmpty) {
              return Center(
                  child: Text(Language.noCategory.capitalizeByWord()));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                mainAxisExtent: 120,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                /*return CategoryCircleCard(
                  categoriesModel: categories[index],
                );*/
                return singleCategoryView(context, categories[index]);
              },
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
      ),
    );
  }

  Widget singleCategoryView(BuildContext context, CategoriesModel categories) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouteNames.singleCategoryProductScreen,
        arguments: {
          'keyword': categories.slug,
          'app_bar': categories.name,
        },
      ),
      child: SizedBox(
        width: 80.0,
        height: 90.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.0,
              height: 75.0,
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Utils.dynamicPrimaryColor(context).withOpacity(0.08),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                  child: CustomImage(
                path: RemoteUrls.imageUrl(categories.image),
                fit: BoxFit.contain,
                height: 45.0,
              )),
            ),
            const SizedBox(height: 4.0),
            Text(
              categories.name,
              textAlign: TextAlign.center,
              style: simpleTextStyle(textGreyColor),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
