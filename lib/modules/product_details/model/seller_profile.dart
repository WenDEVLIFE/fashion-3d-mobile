// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SellerInfoProfile extends Equatable {
  final String name;
  final String email;
  final String image;
  final String address;
  const SellerInfoProfile({
    required this.name,
    required this.email,
    required this.image,
    required this.address,
  });

  SellerInfoProfile copyWith({
    String? name,
    String? email,
    String? image,
    String? address,
  }) {
    return SellerInfoProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
      'address': address,
    };
  }

  factory SellerInfoProfile.fromMap(Map<String, dynamic> map) {
    return SellerInfoProfile(
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      image: map['image'] ?? "",
      address: map['address'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerInfoProfile.fromJson(String source) => SellerInfoProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email, image, address];
}
