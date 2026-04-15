import 'package:furniture_app/feature/bottom_navigation_bar/presentation/provider/bottom_navigation_bar_provider.dart';
import 'package:furniture_app/feature/on_boarding/presentation/provider/on_boarding_provider.dart';
import 'package:get_it/get_it.dart';

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
    // Example:
    // final sharedPreferences = await SharedPreferences.getInstance();
    // getIt.registerLazySingleton(() => sharedPreferences);

    // Firebase / HTTP / Dio etc.
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

  // =========================
  // 🔹 CORE SERVICES
  // =========================
  static void _initServices() {
    // getIt.registerLazySingleton<NetworkService>(
    //       () => NetworkService(),
    // );
    //
    // getIt.registerLazySingleton<FirebaseService>(
    //       () => FirebaseService(),
    // );
  }

  //! 🔹 AUTH FEATURE
  static void _initAuth() {
    // 📡 DataSource
    // getIt.registerLazySingleton<AuthRemoteDataSource>(
    //       () => AuthRemoteDataSource(),
    // );
    //
    // // 📦 Repository
    // getIt.registerLazySingleton<AuthRepository>(
    //       () => AuthRepositoryImpl(getIt()),
    // );
    //
    // // ⚙️ UseCase
    // getIt.registerLazySingleton<LoginUseCase>(
    //       () => LoginUseCase(getIt()),
    // );
    //
    // // 🎯 Provider / Controller
    // getIt.registerFactory<AuthProvider>(
    //       () => AuthProvider(loginUseCase: getIt()),
    // );
  }
}
