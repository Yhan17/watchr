import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/services/auth_service.dart';
import 'package:watchr/app/core/infra/services/auth_service_impl.dart';
import 'package:watchr/app/core/providers/core_providers.dart';
import 'package:watchr/app/core/providers/service_provider.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  group('AuthService Provider', () {
    test('AuthService Provider initializes AuthServiceImpl', () {
      // Configurar o mock
      final mockFirebaseAuth = MockFirebaseAuth();
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);
      when(() => mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => const Stream.empty());

      // Sobrescrever o provedor para usar o mock
      final container = ProviderContainer(overrides: [
        firebaseAuthProvider.overrideWithValue(mockFirebaseAuth),
      ]);

      // Obter a instância do serviço de autenticação do provedor
      final authService = container.read(authServiceProvider);

      // Verificar se a instância obtida é do tipo correto
      expect(authService, isA<AuthService>());
      expect(authService, isA<AuthServiceImpl>());
    });
  });
}
