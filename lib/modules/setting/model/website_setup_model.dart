// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../category/model/category_model.dart';
import '../../home/model/setting_model.dart';
import 'maintainance_text_model.dart';

class WebsiteSetupModel extends Equatable {
  final SettingModel? setting;
  final bool flashSaleActive;
  final FlashSaleDto flashSale;
  final List<FlashSaleProductsModel> flashSaleProducts;
  final List<CategoriesModel> productCategories;
  final MaintainTextModel? maintainTextModel;

  const WebsiteSetupModel({
    required this.setting,
    required this.flashSaleActive,
    required this.flashSale,
    required this.flashSaleProducts,
    required this.productCategories,
    required this.maintainTextModel,
  });

  WebsiteSetupModel copyWith({
    SettingModel? setting,
    bool? flashSaleActive,
    FlashSaleDto? flashSale,
    List<FlashSaleProductsModel>? flashSaleProducts,
    List<CategoriesModel>? productCategories,
    MaintainTextModel? maintainTextModel,
  }) {
    return WebsiteSetupModel(
      setting: setting ?? this.setting,
      flashSaleActive: flashSaleActive ?? this.flashSaleActive,
      flashSale: flashSale ?? this.flashSale,
      flashSaleProducts: flashSaleProducts ?? this.flashSaleProducts,
      productCategories: productCategories ?? this.productCategories,
      maintainTextModel: maintainTextModel ?? this.maintainTextModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'setting': setting!.toMap(),
      'flashSaleActive': flashSaleActive,
      'flashSale': flashSale.toMap(),
      'flashSaleProducts': flashSaleProducts.map((x) => x.toMap()).toList(),
      'productCategories': productCategories.map((x) => x.toMap()).toList(),
      //'maintainance': maintainTextModel!.toMap(),
      'maintainance_text': maintainTextModel!.toMap(),
    };
  }

  factory WebsiteSetupModel.fromMap(Map<String, dynamic> map) {
    print('MaintainText : ${map['maintainance_text']}');
    return WebsiteSetupModel(
      setting: map['setting'] != null
          ? SettingModel.fromMap(map['setting'] as Map<String, dynamic>)
          : null,
      flashSaleActive: map['flashSaleActive'] as bool,
      flashSale: FlashSaleDto.fromMap(map['flashSale'] as Map<String, dynamic>),
      maintainTextModel:
          map['maintainance_text'] != null ? MaintainTextModel.fromMap(
              // map['maintainance'] as Map<String, dynamic>)
              map['maintainance_text'] as Map<String, dynamic>) : null,
      flashSaleProducts: List<FlashSaleProductsModel>.from(
        (map['flashSaleProducts'] as List<dynamic>).map<FlashSaleProductsModel>(
          (x) => FlashSaleProductsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      productCategories: List<CategoriesModel>.from(
        (map['productCategories'] as List<dynamic>).map<CategoriesModel>(
          (x) => CategoriesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WebsiteSetupModel.fromJson(String source) =>
      WebsiteSetupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      setting!,
      flashSaleActive,
      flashSale,
      maintainTextModel!,
      flashSaleProducts,
      productCategories,
    ];
  }
}

class FlashSaleDto extends Equatable {
  final int status;
  final double offer;
  final String endTime;

  const FlashSaleDto({
    required this.status,
    required this.offer,
    required this.endTime,
  });

  FlashSaleDto copyWith({
    int? status,
    double? offer,
    String? endTime,
  }) {
    return FlashSaleDto(
      status: status ?? this.status,
      offer: offer ?? this.offer,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'offer': offer,
      'end_time': endTime,
    };
  }

  factory FlashSaleDto.fromMap(Map<String, dynamic> map) {
    return FlashSaleDto(
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      offer: map['offer'] != null ? double.parse(map['offer'].toString()) : 0.0,
      endTime: map['end_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlashSaleDto.fromJson(String source) =>
      FlashSaleDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, offer, endTime];
}

class FlashSaleProductsModel extends Equatable {
  final int productId;

  const FlashSaleProductsModel({
    required this.productId,
  });

  FlashSaleProductsModel copyWith({
    int? productId,
  }) {
    return FlashSaleProductsModel(
      productId: this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
    };
  }

  factory FlashSaleProductsModel.fromMap(Map<String, dynamic> map) {
    return FlashSaleProductsModel(
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlashSaleProductsModel.fromJson(String source) =>
      FlashSaleProductsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [productId];
}
