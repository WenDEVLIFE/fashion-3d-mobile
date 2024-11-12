import 'dart:convert';

import 'package:equatable/equatable.dart';

class Errors extends Equatable {
  final List<String> name;
  final List<String> agree;
  final List<String> email;
  final List<String> phone;
  final List<String> password;
  final List<String> address;
  final List<String> country;
  final List<String> state;
  final List<String> city;
  final List<String> subject;
  final List<String> message;
  final List<String> review;
  final List<String> tnxInfo;

  const Errors({
    required this.name,
    required this.agree,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.subject,
    required this.message,
    required this.review,
    required this.tnxInfo,
  });

  Errors copyWith({
    List<String>? name,
    List<String>? email,
    List<String>? phone,
    List<String>? agree,
    List<String>? password,
    List<String>? address,
    List<String>? country,
    List<String>? state,
    List<String>? city,
    List<String>? subject,
    List<String>? message,
    List<String>? review,
    List<String>? tnxInfo,
  }) {
    return Errors(
      name: name ?? this.name,
      agree: agree ?? this.agree,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      address: address ?? this.address,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      review: review ?? this.review,
      tnxInfo: tnxInfo ?? this.tnxInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'agree': agree,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'country': country,
      'state': state,
      'city': city,
      'subject': subject,
      'message': message,
      'review': review,
      'tnx_info': tnxInfo,
    };
  }

  factory Errors.fromMap(Map<String, dynamic> map) {
    return Errors(
      name: map['name'] != null
          ? List<String>.from(map['name'].map((x) => x))
          : [],
      agree: map['agree'] != null
          ? List<String>.from(map['agree'].map((x) => x))
          : [],
      email: map['email'] != null
          ? List<String>.from(map['email'].map((x) => x))
          : [],
      phone: map['phone'] != null
          ? List<String>.from(map['phone'].map((x) => x))
          : [],
      password: map['password'] != null
          ? List<String>.from(map['password'].map((x) => x))
          : [],
      address: map['address'] != null
          ? List<String>.from(map['address'].map((x) => x))
          : [],
      country: map['country'] != null
          ? List<String>.from(map['country'].map((x) => x))
          : [],
      state: map['state'] != null
          ? List<String>.from(map['state'].map((x) => x))
          : [],
      city: map['city'] != null
          ? List<String>.from(map['city'].map((x) => x))
          : [],
      subject: map['subject'] != null
          ? List<String>.from(map['subject'].map((x) => x))
          : [],
      message: map['message'] != null
          ? List<String>.from(map['message'].map((x) => x))
          : [],
      review: map['review'] != null
          ? List<String>.from(map['review'].map((x) => x))
          : [],
      tnxInfo: map['tnx_info'] != null
          ? List<String>.from(map['tnx_info'].map((x) => x))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Errors.fromJson(String source) =>
      Errors.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        name,
        agree,
        email,
        phone,
        password,
        address,
        country,
        state,
        city,
        tnxInfo,
      ];
}
