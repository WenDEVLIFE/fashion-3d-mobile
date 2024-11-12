// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddressResponseModel extends Equatable {
  final int id;
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String countryId;
  final String stateId;
  final String cityId;
  final String address;
  final String type;
  final String defaultShipping;
  final String defaultBilling;
  final String createdAt;
  final String updatedAt;
  const AddressResponseModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.address,
    required this.type,
    required this.defaultShipping,
    required this.defaultBilling,
    required this.createdAt,
    required this.updatedAt,
  });
  

  AddressResponseModel copyWith({
    int? id,
    String? userId,
    String? name,
    String? email,
    String? phone,
    String? countryId,
    String? stateId,
    String? cityId,
    String? address,
    String? type,
    String? defaultShipping,
    String? defaultBilling,
    String? createdAt,
    String? updatedAt,
  }) {
    return AddressResponseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      address: address ?? this.address,
      type: type ?? this.type,
      defaultShipping: defaultShipping ?? this.defaultShipping,
      defaultBilling: defaultBilling ?? this.defaultBilling,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'country_id': countryId,
      'state_id': stateId,
      'city_id': cityId,
      'address': address,
      'type': type,
      'default_shipping': defaultShipping,
      'default_billing': defaultBilling,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory AddressResponseModel.fromMap(Map<String, dynamic> map) {
    return AddressResponseModel(
      id: map['id'] as int,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      countryId: map['country_id'] as String,
      stateId: map['state_id'] as String,
      cityId: map['city_id'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
      defaultShipping: map['default_shipping'] as String,
      defaultBilling: map['default_billing'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressResponseModel.fromJson(String source) => AddressResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      name,
      email,
      phone,
      countryId,
      stateId,
      cityId,
      address,
      type,
      defaultShipping,
      defaultBilling,
      createdAt,
      updatedAt,
    ];
  }
}
