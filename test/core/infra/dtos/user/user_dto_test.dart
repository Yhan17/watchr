import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/user_entity.dart';
import 'package:watchr/app/core/infra/dtos/user/user_dto.dart';

class MockUser extends Mock implements User {}

void main() {
  test('UserDto.fromFirebaseUser creates a valid UserDto', () {
    final mockFirebaseUser = MockUser();
    when(() => mockFirebaseUser.uid).thenReturn('test_uid');
    when(() => mockFirebaseUser.email).thenReturn('test@example.com');
    when(() => mockFirebaseUser.displayName).thenReturn('Test User');
    when(() => mockFirebaseUser.isAnonymous).thenReturn(false);
    when(() => mockFirebaseUser.emailVerified).thenReturn(true);
    when(() => mockFirebaseUser.phoneNumber).thenReturn('123456789');
    ///  {
    ///     "firebase": {
    ///       "sign_in_provider": "password"
    ///     }
    ///  }
    const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
        '.eyJmaXJlYmFzZSI6eyJzaWduX2luX'
        '3Byb3ZpZGVyIjoicGFzc3dvcmQifX0'
        '.PXT97eWCjh7HBoR2KLg8Mv1tChEXFomGcuoLd9L-gqE';

    final userDto = UserDto.fromFirebaseUser(mockFirebaseUser, token);

    expect(userDto.uid, 'test_uid');
    expect(userDto.emailAddress, 'test@example.com');
    expect(userDto.displayName, 'Test User');
    expect(userDto.isAnonymous, false);
    expect(userDto.emailVerified, true);
    expect(userDto.phoneNumber, '123456789');
    expect(userDto.provider, FirebaseProvider.password);


    final userEntity = userDto.toEntity();

    expect(userEntity.uid, 'test_uid');
    expect(userEntity.emailAddress, 'test@example.com');
    expect(userEntity.displayName, 'Test User');
    expect(userEntity.isAnonymous, false);
    expect(userEntity.emailVerified, true);
  });

  test('UserDto.toEntity creates a valid UserEntity', () {
    const userDto = UserDto(
      uid: 'test_uid',
      idToken: 'mock_id_token',
      emailAddress: 'test@example.com',
      displayName: 'Test User',
      isAnonymous: false,
      emailVerified: true,
      provider: FirebaseProvider.unknown,
      phoneNumber: '123456789',
    );

    final userEntity = userDto.toEntity();

    expect(userEntity.uid, 'test_uid');
    expect(userEntity.emailAddress, 'test@example.com');
    expect(userEntity.displayName, 'Test User');
    expect(userEntity.isAnonymous, false);
    expect(userEntity.emailVerified, true);
  });
}
