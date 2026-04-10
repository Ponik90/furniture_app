import 'package:get_it/get_it.dart';


final GetIt getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    await _initThirdParty();
    _initServices();

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

  // =========================
  // 🔹 AUTH FEATURE
  // =========================
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