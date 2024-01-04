import 'package:flutter_test/flutter_test.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';

void main() {
  group('WatchEntity', () {
    test('Two WatchEntity instances with the same properties should be equal',
        () {
      final watch1 = WatchEntity(
        id: '1',
        name: 'Watch 1',
        description: 'Description 1',
        price: 99.99,
        stockQuantity: 10,
        code: 'W123',
        imageStoragePath: 'path/to/image1.jpg',
        userId: 'user1',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024, 1, 2),
      );

      final watch2 = WatchEntity(
        id: '1',
        name: 'Watch 1',
        description: 'Description 1',
        price: 99.99,
        stockQuantity: 10,
        code: 'W123',
        imageStoragePath: 'path/to/image1.jpg',
        userId: 'user1',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024, 1, 2),
      );

      expect(watch1, equals(watch2));
    });

    test('WatchEntity instances with different properties should not be equal',
        () {
      final watch1 = WatchEntity(
        id: '1',
        name: 'Watch 1',
        description: 'Description 1',
        price: 99.99,
        stockQuantity: 10,
        code: 'W123',
        imageStoragePath: 'path/to/image1.jpg',
        userId: 'user1',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024, 1, 2),
      );

      final watch2 = WatchEntity(
        id: '2', // Different ID
        name: 'Watch 1',
        description: 'Description 1',
        price: 99.99,
        stockQuantity: 10,
        code: 'W123',
        imageStoragePath: 'path/to/image1.jpg',
        userId: 'user1',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024, 1, 2),
      );

      expect(watch1, isNot(equals(watch2)));
    });
  });
}
