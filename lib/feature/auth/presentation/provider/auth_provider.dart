import 'dart:developer';
import 'package:furniture_app/core/constant/app_imports.dart';
import 'package:furniture_app/core/services/storage_service/storage_service.dart';
import 'package:furniture_app/feature/auth/domain/usecase/complete_profile_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_account_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_user_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/login_use_case.dart';

class AuthProvider extends ChangeNotifier {
  final StorageService storageService;
  final LoginUseCase loginUseCase;
  final CreateAccountUseCase createAccountUseCase;
  final CreateUserUseCase createUserUseCase;
  final CompleteProfileUseCase completeProfileUseCase;

  AuthProvider({
    required this.storageService,
    required this.loginUseCase,
    required this.createAccountUseCase,
    required this.createUserUseCase,
    required this.completeProfileUseCase,
  });

  Future<void> navigateAccordingState() async {
    final isLogeIn = storageService.getBool(key: 'isLogin');
    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      if (isLogeIn ?? false) {
        context.goNamed(Routes.homeScreen.name);
      } else {
        context.goNamed(Routes.loginScreen.name);
      }
    }
  }

  Future<void> login({required String email, required String password}) async {
    final result = await loginUseCase.call(
      UserEmailPassParms(email: email, pass: password),
    );
    result.fold(
      (l) {
        log("login failed message :: ${l.message}");
      },
      (r) {
        log("successful message :: ${r.credential}");
        storageService.setBool(key: 'isLogin', value: true);
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          context.goNamed(Routes.homeScreen.name);
        }
      },
    );
  }

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    final result = await createAccountUseCase.call(
      UserEmailPassParms(email: email, pass: password),
    );
    result.fold(
      (l) {
        log("login failed message :: ${l.message}");
      },
      (r) {
        log("successful message :: ${r.credential}");
        createUser(
          email: r.user?.email ?? "",
          name: r.user?.displayName ?? "",
          userId: r.user?.uid ?? "",
        );
      },
    );
  }

  Future<void> createUser({
    required String email,
    required String name,
    required String userId,
  }) async {
    final result = await createUserUseCase.call(
      CreateUserParams(email: email, name: name, userId: userId),
    );
    result.fold(
      (l) {
        log("login failed message :: ${l.message}");
      },
      (r) {
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          context.goNamed(Routes.completeProfileScreen.name);
        }
      },
    );
  }

  Future<void> completeProfile({
    required String email,
    required String password,
  }) async {
    final result = await createAccountUseCase.call(
      UserEmailPassParms(email: email, pass: password),
    );
    result.fold(
      (l) {
        log("login failed message :: ${l.message}");
      },
      (r) {
        log("successful message :: ${r.credential}");
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          context.goNamed(Routes.completeProfileScreen.name);
        }
      },
    );
  }
}
