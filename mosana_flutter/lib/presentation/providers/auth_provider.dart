import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_client.dart';
import '../../core/services/api_service.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/storage_service.dart';
import '../../data/repositories/post_repository.dart';

// ===================== CORE SERVICES =====================

/// Storage service provider (singleton)
final storageServiceProvider = Provider<StorageService>((ref) {
  final storage = StorageService();
  // Initialize on first access
  storage.init();
  return storage;
});

/// Dio client provider (singleton)
final dioClientProvider = Provider<DioClient>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return DioClient(storage);
});

/// API service provider
final apiServiceProvider = Provider<ApiService>((ref) {
  final client = ref.watch(dioClientProvider);
  return ApiService(client: client);
});

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  final client = ref.watch(dioClientProvider);
  final storage = ref.watch(storageServiceProvider);
  return AuthService(
    dioClient: client,
    storage: storage,
  );
});

// ===================== REPOSITORIES =====================

/// Post repository provider
final postRepositoryProvider = Provider<PostRepository>((ref) {
  final api = ref.watch(apiServiceProvider);
  return PostRepository(api: api);
});

// ===================== AUTH STATE =====================

/// Current auth state provider
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) {
    final authService = ref.watch(authServiceProvider);
    return AuthStateNotifier(authService: authService);
  },
);

/// Auth state notifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthStateNotifier({required AuthService authService})
      : _authService = authService,
        super(const AuthState.initial()) {
    // Try auto-login on init
    _tryAutoLogin();
  }

  /// Try to auto-login user
  Future<void> _tryAutoLogin() async {
    state = const AuthState.loading();

    final result = await _authService.autoLogin();

    if (result != null && result.success) {
      state = AuthState.authenticated(
        walletAddress: result.walletAddress!,
        username: result.username!,
      );
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  /// Connect wallet
  Future<void> connectWallet({
    required String walletAddress,
    required String signature,
    String? publicKey,
  }) async {
    state = const AuthState.loading();

    final result = await _authService.connectWallet(
      walletAddress: walletAddress,
      signature: signature,
      publicKey: publicKey,
    );

    if (result.success) {
      state = AuthState.authenticated(
        walletAddress: result.walletAddress!,
        username: result.username!,
        isNewUser: result.isNewUser,
      );
    } else {
      state = AuthState.error(result.error ?? 'Authentication failed');
    }
  }

  /// Mock wallet connection (for development)
  Future<void> connectMockWallet(String username) async {
    state = const AuthState.loading();

    final result = await _authService.connectMockWallet(username);

    if (result.success) {
      state = AuthState.authenticated(
        walletAddress: result.walletAddress!,
        username: result.username!,
        isNewUser: result.isNewUser,
      );
    } else {
      state = AuthState.error(result.error ?? 'Mock connection failed');
    }
  }

  /// Logout
  Future<void> logout() async {
    await _authService.logout();
    state = const AuthState.unauthenticated();
  }

  /// Clear error
  void clearError() {
    if (state is _AuthStateError) {
      state = const AuthState.unauthenticated();
    }
  }
}

/// Auth state sealed class
sealed class AuthState {
  const AuthState();

  const factory AuthState.initial() = _AuthStateInitial;
  const factory AuthState.loading() = _AuthStateLoading;
  const factory AuthState.authenticated({
    required String walletAddress,
    required String username,
    bool isNewUser,
  }) = _AuthStateAuthenticated;
  const factory AuthState.unauthenticated() = _AuthStateUnauthenticated;
  const factory AuthState.error(String message) = _AuthStateError;
}

class _AuthStateInitial extends AuthState {
  const _AuthStateInitial();
}

class _AuthStateLoading extends AuthState {
  const _AuthStateLoading();
}

class _AuthStateAuthenticated extends AuthState {
  final String walletAddress;
  final String username;
  final bool isNewUser;

  const _AuthStateAuthenticated({
    required this.walletAddress,
    required this.username,
    this.isNewUser = false,
  });
}

class _AuthStateUnauthenticated extends AuthState {
  const _AuthStateUnauthenticated();
}

class _AuthStateError extends AuthState {
  final String message;
  const _AuthStateError(this.message);
}

// ===================== CONVENIENCE GETTERS =====================

/// Check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState is _AuthStateAuthenticated;
});

/// Get current wallet address (null if not authenticated)
final currentWalletProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  if (authState is _AuthStateAuthenticated) {
    return authState.walletAddress;
  }
  return null;
});

/// Get current username (null if not authenticated)
final currentUsernameProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  if (authState is _AuthStateAuthenticated) {
    return authState.username;
  }
  return null;
});
