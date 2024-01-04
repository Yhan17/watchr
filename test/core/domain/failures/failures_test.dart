import 'package:flutter_test/flutter_test.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';

void main() {
  group('Failures', () {
    test('support value equality', () {
      const failure1 = Failures.serviceFailure;
      const failure2 = Failures.serviceFailure;

      expect(failure1, equals(failure2));
    });

    test('have unique messages', () {
      final messages =
          Failures.values.map((failure) => failure.message).toSet();

      expect(messages, hasLength(Failures.values.length));
    });

    test('toString returns the correct message', () {
      const failure = Failures.repositoryFailure;

      expect(failure.message,
          equals('an error occurred in the repository'));
    });

    test('values are unique', () {
      final uniqueValues = Failures.values.toSet();

      expect(uniqueValues, hasLength(Failures.values.length));
    });
  });
}
