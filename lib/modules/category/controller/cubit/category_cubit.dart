import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../seller/model/seller_model.dart';
import '/modules/category/model/filter_model.dart';
import '../../../home/model/product_model.dart';
import '../../model/category_model.dart';
import '../../model/product_categories_model.dart';
import '../repository/category_repositry.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(CategoryRepository categoryRepository)
      : _categoryRepository = categoryRepository,
        super(CategoryLoadingState());
  final CategoryRepository _categoryRepository;
  late ProductCategoriesModel productCategoriesModel;
  late List<ProductModel> categoryProducts;
  late List<ProductModel> brandProducts;
  late List<CategoriesModel> categoryList;
  late SellerProductModel sellerProductModel;

  Future<void> getCategoryList() async {
    emit(CategoryLoadingState());

    final result = await _categoryRepository.getCategoryList();
    result.fold(
      (failure) {
        emit(CategoryErrorState(errorMessage: failure.message));
      },
      (data) {
        categoryList = data;

        emit(CategoryListLoadedState(categoryListModel: data));
      },
    );
  }

  Future<void> getCategoryProduct(String slug) async {
    emit(CategoryLoadingState());

    final result = await _categoryRepository.getCategoryProducts(slug);
    result.fold(
      (failure) {
        emit(CategoryErrorState(errorMessage: failure.message));
      },
      (data) {
        productCategoriesModel = data;
        categoryProducts = data.products;
        log(productCategoriesModel.products.length.toString(),
            name: "CategoryCubit");
        emit(CategoryLoadedState(categoryProducts: data.products));
      },
    );
  }

  Future<void> getSellerProduct(String slug) async {
    emit(CategoryLoadingState());

    final result = await _categoryRepository.getSellerList(slug);

    result.fold((f) {
      emit(CategoryErrorState(errorMessage: f.message));
    }, (sellerData) {
      sellerProductModel = sellerData;
      emit(SellerProductState(sellerModel: sellerData));
    });
  }

  Future<void> getFilterProducts(FilterModelDto filterModelDto) async {
    emit(CategoryLoadingState());

    final result = await _categoryRepository.getFilterProducts(filterModelDto);
    result.fold(
      (failure) {
        emit(CategoryErrorState(errorMessage: failure.message));
      },
      (data) {
        categoryProducts = data;

        log(productCategoriesModel.products.length.toString(),
            name: "CategoryCubit");
        emit(CategoryLoadedState(categoryProducts: data));
      },
    );
  }

  Future<void> getBrandProduct(String slug) async {
    emit(CategoryLoadingState());

    final result = await _categoryRepository.getBrandProducts(slug);
    result.fold(
      (failure) {
        emit(CategoryErrorState(errorMessage: failure.message));
      },
      (data) {
        brandProducts = data;
        emit(CategoryLoadedState(categoryProducts: data));
      },
    );
  }
}
