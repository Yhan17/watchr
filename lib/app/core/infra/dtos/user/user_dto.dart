import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../domain/entities/user_entity.dart';

@immutable
class UserDto {
  final String uid;
  final String idToken;
  final String? emailAddress;
  final String? displayName;
  final bool isAnonymous;
  final bool emailVerified;
  final FirebaseProvider provider;
  final String? phoneNumber;

  const UserDto({
    required this.uid,
    required this.idToken,
    required this.emailAddress,
    required this.displayName,
    required this.isAnonymous,
    required this.emailVerified,
    required this.provider,
    required this.phoneNumber,
  });

  factory UserDto.fromFirebaseUser(
    User firebaseUser,
    String token,
  ) {
    Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
    final providerString = decodeToken['firebase']['sign_in_provider'];
    final provider = stringToProvider(providerString);
    return UserDto(
      uid: firebaseUser.uid,
      idToken: token,
      emailAddress: firebaseUser.email,
      displayName: firebaseUser.displayName,
      isAnonymous: firebaseUser.isAnonymous,
      emailVerified: firebaseUser.emailVerified,
      provider: provider!,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }

  UserEntity toEntity() => UserEntity(
        uid: uid,
        idToken: idToken,
        emailAddress: emailAddress,
        displayName: displayName,
        isAnonymous: isAnonymous,
        emailVerified: emailVerified,
        provider: provider,
      );
}
