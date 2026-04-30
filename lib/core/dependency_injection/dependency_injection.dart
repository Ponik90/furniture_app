import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:furniture_app/core/services/storage_service/storage_service.dart';
import 'package:furniture_app/feature/auth/data/remote_data/auth_remote_data.dart';
import 'package:furniture_app/feature/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:furniture_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:furniture_app/feature/auth/domain/usecase/complete_profile_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_account_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_user_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/login_use_case.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';
import 'package:furniture_app/feature/bottom_navigation_bar/presentation/provider/bottom_navigation_bar_provider.dart';
import 'package:furniture_app/feature/on_boarding/presentation/provider/on_boarding_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    await _initThirdParty();
    _initServices();

    _initOnBoarding();
    _initBottomNavigation();
    _initAuth();
    // 👉 later:
    // _initProduct();
    // _initCart();
  }

  // =========================
  // 🔹 THIRD PARTY
  // =========================
  static Future<void> _initThirdParty() async {
    // shared preferences
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPreferences);

    // Firebase
    final firebaseAuth = FirebaseAuth.instance;
    getIt.registerLazySingleton(() => firebaseAuth);

    final firebaseFirestore = FirebaseFirestore.instance;
    getIt.registerLazySingleton(() => firebaseFirestore);
  }

  // =========================
  // 🔹 CORE SERVICES
  // =========================
  static void _initServices() {
    getIt.registerLazySingleton<StorageService>(
      () => StorageServiceImpl(sharedPreferences: getIt<SharedPreferences>()),
    );
    //
    // getIt.registerLazySingleton<FirebaseService>(
    //       () => FirebaseService(),
    // );
  }

  //! 🔹 Onboarding FEATURE
  static void _initOnBoarding() {
    // 🎯 Provider
    getIt.registerFactory<OnBoardingProvider>(() => OnBoardingProvider());
  } //! 🔹 Onboarding FEATURE

  static void _initBottomNavigation() {
    // 🎯 Provider
    getIt.registerFactory<BottomNavigationBarProvider>(
      () => BottomNavigationBarProvider(),
    );
  }

  //! 🔹 AUTH FEATURE
  static void _initAuth() {
    // 📡 DataSource
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: getIt<FirebaseAuth>(),
        firebaseFirestore: getIt<FirebaseFirestore>(),
      ),
    );
    //
    // 📦 Repository
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remote: getIt<AuthRemoteDataSource>()),
    );

    // ⚙️ UseCase
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<CreateAccountUseCase>(
      () => CreateAccountUseCase(authRepository: getIt<AuthRepository>()),
    );

    // 🎯 Provider / Controller
    getIt.registerFactory<AuthProvider>(
      () => AuthProvider(
        storageService: getIt<StorageService>(),
        loginUseCase: getIt<LoginUseCase>(),
        createAccountUseCase: getIt<CreateAccountUseCase>(),
        createUserUseCase: getIt<CreateUserUseCase>(),
        completeProfileUseCase: getIt<CompleteProfileUseCase>(),
      ),
    );
  }
}
