/*
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SectionTitleModel extends Equatable {
  final String key;
  final String? defaultTitle;
  final String? custom;

  const SectionTitleModel(
      {required this.key, required this.defaultTitle, required this.custom});

  SectionTitleModel copyWith({
    String? key,
    String? defaultTitle,
    String? custom,
  }) {
    return SectionTitleModel(
      key: key ?? this.key,
      defaultTitle: defaultTitle ?? this.defaultTitle,
      custom: custom ?? this.custom,
    );
  }

  factory SectionTitleModel.fromMap(Map<String, dynamic> map) {
    return SectionTitleModel(
      key: map['key'],
      defaultTitle: map['default'],
      custom: map['custom'],
    );
  }

  factory SectionTitleModel.fromJson(String source) =>
      SectionTitleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SectionTitleModel(key: $key, default: $defaultTitle, custom: $custom)';
  }

  @override
  List<Object?> get props => [key, defaultTitle, custom];
}
*/

import 'dart:convert';

import 'package:equatable/equatable.dart';

class SectionTitleModel extends Equatable {
  final String key;
  String? defaultTitle;
  String? custom;

  SectionTitleModel(
      {required this.key, required this.defaultTitle, required this.custom});

  SectionTitleModel copyWith({
    String? key,
    String? defaultTitle,
    String? custom,
  }) {
    return SectionTitleModel(
      key: key ?? this.key,
      defaultTitle: defaultTitle ?? this.defaultTitle,
      custom: custom ?? this.custom,
    );
  }

  factory SectionTitleModel.fromMap(Map<String, dynamic> map) {
    return SectionTitleModel(
      key: map['key'],
      defaultTitle: map['default'],
      custom: map['custom'],
    );
  }

  factory SectionTitleModel.fromJson(String source) =>
      SectionTitleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SectionTitleModel(key: $key, default: $defaultTitle, custom: $custom)';
  }

  @override
  List<Object?> get props => [key, defaultTitle, custom];
}

