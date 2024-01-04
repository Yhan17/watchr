import 'package:flutter_test/flutter_test.dart';
import 'package:watchr/app/core/domain/entities/user_entity.dart';


void main() {
  group('UserEntity', () {
    test('Supports value equality', () {
      
      const user1 = UserEntity(
        uid: '1',
        idToken: 'token1',
        emailAddress: 'user1@example.com',
        displayName: 'User One',
        isAnonymous: false,
        emailVerified: true,
        provider: FirebaseProvider.password,
        phoneNumber: '123456789',
      );

      const user2 = UserEntity(
        uid: '1',
        idToken: 'token1',
        emailAddress: 'user1@example.com',
        displayName: 'User One',
        isAnonymous: false,
        emailVerified: true,
        provider: FirebaseProvider.password,
        phoneNumber: '123456789',
      );

      expect(user1, equals(user2));
    });
  });
}
