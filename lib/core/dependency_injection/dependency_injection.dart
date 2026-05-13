import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:furniture_app/core/services/cloudinary_upload_image_service/upload_image_service.dart';
import 'package:furniture_app/core/services/storage_service/storage_service.dart';
import 'package:furniture_app/feature/auth/data/remote_data/auth_remote_data.dart';
import 'package:furniture_app/feature/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:furniture_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:furniture_app/feature/auth/domain/usecase/check_user_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/complete_profile_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_account_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/create_user_use_case.dart';
import 'package:furniture_app/feature/auth/domain/usecase/login_use_case.dart';
import 'package:furniture_app/feature/auth/presentation/provider/auth_provider.dart';
import 'package:furniture_app/feature/bottom_navigation_bar/presentation/provider/bottom_navigation_bar_provider.dart';
import 'package:furniture_app/feature/home/data/remote_data/home_remote_data.dart';
import 'package:furniture_app/feature/home/data/repository_impl/home_repository_impl.dart';
import 'package:furniture_app/feature/home/domian/repository/home_repository.dart';
import 'package:furniture_app/feature/home/presentation/provider/home_provider.dart';
import 'package:furniture_app/feature/on_boarding/presentation/provider/on_boarding_provider.dart';
import 'package:furniture_app/feature/profile/data/data_source/profile_remote_data.dart';
import 'package:furniture_app/feature/profile/data/repository_impl/profile_repository_impl.dart';
import 'package:furniture_app/feature/profile/domain/use_case/get_profile_use_case.dart';
import 'package:furniture_app/feature/profile/domain/use_case/update_profile_use_case.dart';
import 'package:furniture_app/feature/profile/presentation/provider/profile_provider.dart';
import 'package:furniture_app/feature/cart/presentation/provider/cart_provider.dart';
import 'package:furniture_app/feature/home/presentation/provider/favorite_provider.dart';
import 'package:furniture_app/feature/home/presentation/provider/search_provider.dart';
import 'package:furniture_app/feature/profile/presentation/provider/address_provider.dart';
import 'package:furniture_app/feature/profile/presentation/provider/wallet_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/profile/domain/repository/profile_repository.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    await _initThirdParty();
    _initServices();

    _initOnBoarding();
    _initBottomNavigation();
    _initAuth();
    _initHome();
    _initFavorite();
    _initCart();
    _initAddress();
    _initWallet();
    _initSearch();
    _initProfile();
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
    getIt.registerLazySingleton<UploadImageService>(
      () => UploadImageService(dio: Dio()),
    );

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
    getIt.registerLazySingleton<CreateUserUseCase>(
      () => CreateUserUseCase(authRepository: getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<CompleteProfileUseCase>(
      () => CompleteProfileUseCase(authRepository: getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<CheckUserUseCase>(
      () => CheckUserUseCase(authRepository: getIt<AuthRepository>()),
    );

    // 🎯 Provider / Controller
    getIt.registerFactory<AuthProvider>(
      () => AuthProvider(
        storageService: getIt<StorageService>(),
        uploadImageService: getIt<UploadImageService>(),
        checkUserUseCase: getIt<CheckUserUseCase>(),
        loginUseCase: getIt<LoginUseCase>(),
        createAccountUseCase: getIt<CreateAccountUseCase>(),
        createUserUseCase: getIt<CreateUserUseCase>(),
        completeProfileUseCase: getIt<CompleteProfileUseCase>(),
      ),
    );
  }

  static void _initHome() {
    // 📡 DataSource
    getIt.registerLazySingleton<HomeRemoteData>(
      () => HomeRemoteDataImpl(
        // firebaseFirestore: getIt<FirebaseFirestore>(),
      ),
    );
    //
    // 📦 Repository
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeRemoteData: getIt<HomeRemoteData>()),
    );

    // // ⚙️ UseCase
    // getIt.registerLazySingleton<LoginUseCase>(
    //   () => LoginUseCase(authRepository: getIt<AuthRepository>()),
    // );
    // getIt.registerLazySingleton<CreateAccountUseCase>(
    //   () => CreateAccountUseCase(authRepository: getIt<AuthRepository>()),
    // );
    // getIt.registerLazySingleton<CreateUserUseCase>(
    //   () => CreateUserUseCase(authRepository: getIt<AuthRepository>()),
    // );
    // getIt.registerLazySingleton<CompleteProfileUseCase>(
    //   () => CompleteProfileUseCase(authRepository: getIt<AuthRepository>()),
    // );

    // 🎯 Provider / Controller
    getIt.registerFactory<HomeProvider>(
      () => HomeProvider(storageService: getIt<StorageService>()),
    );
  }

  static void _initProfile() {
    // 📡 DataSource
    getIt.registerLazySingleton<ProfileRemoteData>(
      () =>
          ProfileRemoteDataImpl(firebaseFirestore: getIt<FirebaseFirestore>()),
    );
    // 📦 Repository
    getIt.registerLazySingleton<ProfileRepository>(
      () =>
          ProfileRepositoryImpl(profileRemoteData: getIt<ProfileRemoteData>()),
    );

    // ⚙️ UseCase
    getIt.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(profileRepository: getIt<ProfileRepository>()),
    );
    getIt.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(profileRepository: getIt<ProfileRepository>()),
    );
    // 🎯 Provider / Controller
    getIt.registerFactory<ProfileProvider>(
      () => ProfileProvider(
        storageService: getIt<StorageService>(),
        uploadImageService: getIt<UploadImageService>(),
        getProfileUseCase: getIt<GetProfileUseCase>(),
        updateProfileUseCase: getIt<UpdateProfileUseCase>(),
      ),
    );
  }

  static void _initCart() {
    getIt.registerFactory<CartProvider>(() => CartProvider());
  }

  static void _initFavorite() {
    getIt.registerFactory<FavoriteProvider>(() => FavoriteProvider());
  }

  static void _initAddress() {
    getIt.registerFactory<AddressProvider>(() => AddressProvider());
  }

  static void _initWallet() {
    getIt.registerFactory<WalletProvider>(() => WalletProvider());
  }

  static void _initSearch() {
    getIt.registerFactory<SearchProvider>(() => SearchProvider());
  }
}
