import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomeSellerModel extends Equatable {
  final int id;
  final String bannerImage;
  final String logo;
  final String shopName;
  final String slug;
  const HomeSellerModel({
    required this.id,
    required this.bannerImage,
    required this.logo,
    required this.shopName,
    required this.slug,
  });

  HomeSellerModel copyWith({
    int? id,
    String? bannerImage,
    String? logo,
    String? shopName,
    String? slug,
  }) {
    return HomeSellerModel(
      id: id ?? this.id,
      bannerImage: bannerImage ?? this.bannerImage,
      logo: logo ?? this.logo,
      shopName: shopName ?? this.shopName,
      slug: slug ?? this.slug,
    );
  }

  factory HomeSellerModel.fromMap(Map<String, dynamic> map) {
    return HomeSellerModel(
      id: map['id']?.toInt() ?? 0,
      bannerImage: map['banner_image'] ?? '',
      logo: map['logo'] ?? '',
      shopName: map['shop_name'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  factory HomeSellerModel.fromJson(String source) =>
      HomeSellerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeSellerModel(id: $id, bannerImage: $bannerImage, logo: $logo, shopName: $shopName, slug: $slug)';
  }

  @override
  List<Object> get props => [id, bannerImage, logo, shopName, slug];
}
