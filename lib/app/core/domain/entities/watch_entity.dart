import 'package:equatable/equatable.dart';

class WatchEntity extends Equatable {
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

  const WatchEntity({
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

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      price,
      stockQuantity,
      code,
      imageStoragePath,
      userId,
      createdAt,
      updatedAt,
    ];
  }

  WatchEntity copyWith({
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
    return WatchEntity(
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
}
