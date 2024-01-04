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
  List<Object?> get props => [
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
