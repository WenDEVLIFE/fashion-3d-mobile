// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class VariantItemModel extends Equatable {
  final int id;
  final String productVariantName;
  final String name;

  final double price;
  const VariantItemModel({
    required this.id,
    required this.productVariantName,
    required this.name,
    required this.price,
  });

  VariantItemModel copyWith({
    int? id,
    String? productVariantName,
    String? name,
    double? price,
  }) {
    return VariantItemModel(
      id: id ?? this.id,
      productVariantName: productVariantName ?? this.productVariantName,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_variant_name': productVariantName,
      'name': name,
      'price': price,
    };
  }

  factory VariantItemModel.fromMap(Map<String, dynamic> map) {
    return VariantItemModel(
      id: map['id'] ?? 0,
      productVariantName: map['product_variant_name'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] != null ? double.parse(map['price'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariantItemModel.fromJson(String source) =>
      VariantItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, productVariantName, name, price];
}
