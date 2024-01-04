import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String idToken;
  final String? emailAddress;
  final String? displayName;
  final bool isAnonymous;
  final bool emailVerified;
  final FirebaseProvider provider;
  final String? phoneNumber;

  const UserEntity({
    required this.uid,
    required this.idToken,
    required this.emailAddress,
    required this.displayName,
    required this.isAnonymous,
    required this.emailVerified,
    required this.provider,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        uid,
        idToken,
        emailAddress,
        displayName,
        isAnonymous,
        emailVerified,
        provider,
        phoneNumber,
      ];
}

enum FirebaseProvider {
  password('Email and Password'),
  phone('Phone Number'),
  anonymous('Anonymous'),
  google('Google'),
  facebook('Facebook'),
  apple('Apple'),
  unknown('Unknown');

  final String message;

  const FirebaseProvider(this.message);
}

FirebaseProvider? stringToProvider(String input) => const <String, FirebaseProvider>{
      'password': FirebaseProvider.password,
      'phone': FirebaseProvider.phone,
      'anonymous': FirebaseProvider.anonymous,
      'google.com': FirebaseProvider.google,
      'facebook.com': FirebaseProvider.facebook,
      'unknown': FirebaseProvider.unknown,
    }[input];
