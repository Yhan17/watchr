
import 'package:flutter_test/flutter_test.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/infra/dtos/watch_dto.dart';

void main() {
  group('WatchDto', () {
    test('fromMap should create a WatchDto from a map', () {
      final watchMap = {
        'id': '1',
        'name': 'Watch 1',
        'description': 'Description 1',
        'price': 99.99,
        'stock_quantity': 10,
        'code': 'W123',
        'image_storage_path': 'path/to/image1.jpg',
        'user_id': 'user1',
        'created_at': DateTime(2022).toString(),
        'updated_at': DateTime(2022, 1, 2).toString(),
      };

      final watchDto = WatchDto.fromMap(watchMap);

      expect(watchDto.id, equals('1'));
      expect(watchDto.name, equals('Watch 1'));
      expect(watchDto.description, equals('Description 1'));
      expect(watchDto.price, equals(99.99));
      expect(watchDto.stockQuantity, equals(10));
      expect(watchDto.code, equals('W123'));
      expect(watchDto.imageStoragePath, equals('path/to/image1.jpg'));
      expect(watchDto.userId, equals('user1'));
      expect(watchDto.createdAt, equals(DateTime(2022)));
      expect(watchDto.updatedAt, equals(DateTime(2022, 1, 2)));
    });

    test('toMap should convert a WatchDto to a map', () {
      final watchDto = WatchDto(
        id: '1',
        name: 'Watch 1',
        description: 'Description 1',
        price: 99.99,
        stockQuantity: 10,
        code: 'W123',
        imageStoragePath: 'path/to/image1.jpg',
        userId: 'user1',
        createdAt: DateTime(2022),
        updatedAt: DateTime(2022, 1, 2),
      );

      final watchMap = watchDto.toMap();

      expect(watchMap['id'], equals('1'));
      expect(watchMap['name'], equals('Watch 1'));
      expect(watchMap['description'], equals('Description 1'));
      expect(watchMap['price'], equals(99.99));
      expect(watchMap['stock_quantity'], equals(10));
      expect(watchMap['code'], equals('W123'));
      expect(watchMap['image_storage_path'], equals('path/to/image1.jpg'));
      expect(watchMap['user_id'], equals('user1'));
      expect(watchMap['created_at'], equals(DateTime(2022).millisecondsSinceEpoch));
      expect(watchMap['updated_at'], equals(DateTime(2022, 1, 2).millisecondsSinceEpoch));
    });

    test('fromEntity should create a WatchDto from a WatchEntity', () {
      final watchEntity = WatchEntity(
        id: '1',
        name: 'Watch 1',
        description: 'Description 1',
        price: 99.99,
        stockQuantity: 10,
        code: 'W123',
        imageStoragePath: 'path/to/image1.jpg',
        userId: 'user1',
        createdAt: DateTime(2022),
        updatedAt: DateTime(2022, 1, 2),
      );

      final watchDto = WatchDto.fromEntity(watchEntity);

      expect(watchDto.id, equals('1'));
      expect(watchDto.name, equals('Watch 1'));
      expect(watchDto.description, equals('Description 1'));
      expect(watchDto.price, equals(99.99));
      expect(watchDto.stockQuantity, equals(10));
      expect(watchDto.code, equals('W123'));
      expect(watchDto.imageStoragePath, equals('path/to/image1.jpg'));
      expect(watchDto.userId, equals('user1'));
      expect(watchDto.createdAt, equals(DateTime(2022)));
      expect(watchDto.updatedAt, equals(DateTime(2022, 1, 2)));
    });

    test('toEntity should convert a WatchDto to a WatchEntity', () {
      final watchDto = WatchDto(
        id: '1',
        name: 'Watch 1',
        description: 'Description 1',
        price: 99.99,
        stockQuantity: 10,
        code: 'W123',
        imageStoragePath: 'path/to/image1.jpg',
        userId: 'user1',
        createdAt: DateTime(2022),
        updatedAt: DateTime(2022, 1, 2),
      );

      final watchEntity = watchDto.toEntity();

      expect(watchEntity.id, equals('1'));
      expect(watchEntity.name, equals('Watch 1'));
      expect(watchEntity.description, equals('Description 1'));
      expect(watchEntity.price, equals(99.99));
      expect(watchEntity.stockQuantity, equals(10));
      expect(watchEntity.code, equals('W123'));
      expect(watchEntity.imageStoragePath, equals('path/to/image1.jpg'));
      expect(watchEntity.userId, equals('user1'));
      expect(watchEntity.createdAt, equals(DateTime(2022)));
      expect(watchEntity.updatedAt, equals(DateTime(2022, 1, 2)));
    });
  });
}
