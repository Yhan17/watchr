// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import '../../domain/entities/watch_entity.dart';

@immutable
class WatchDto {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  final String code;
  final String imageStoragePath;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WatchDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.code,
    required this.imageStoragePath,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  WatchDto copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? stockQuantity,
    String? code,
    String? imageStoragePath,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WatchDto(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      code: code ?? this.code,
      imageStoragePath: imageStoragePath ?? this.imageStoragePath,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory WatchDto.fromMap(Map<String, dynamic> map) {
    return WatchDto(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      stockQuantity: map['stock_quantity'] as int,
      code: map['code'] as String,
      imageStoragePath: map['image_storage_path'] as String,
      userId: map['user_id'] as String,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock_quantity': stockQuantity,
      'code': code,
      'image_storage_path': imageStoragePath,
      'user_id': userId,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  WatchEntity toEntity() => WatchEntity(
        id: id,
        name: name,
        description: description,
        price: price,
        stockQuantity: stockQuantity,
        code: code,
        imageStoragePath: imageStoragePath,
        userId: userId,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory WatchDto.fromEntity(WatchEntity entity) {
    return WatchDto(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      stockQuantity: entity.stockQuantity,
      code: entity.code,
      imageStoragePath: entity.imageStoragePath,
      userId: entity.userId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
