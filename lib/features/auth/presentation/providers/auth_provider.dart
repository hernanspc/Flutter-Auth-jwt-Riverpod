import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

//! State notifier afuera
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(
    authRepository: authRepository,
  );
});

//! Como implemetamos un notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNotifier({required this.authRepository}) : super(AuthState());

  void loginUser(String email, String password) async {}

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {}
}

//! State del provider
enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
