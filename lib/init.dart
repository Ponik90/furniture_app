import 'package:flutter/widgets.dart';

import 'core/dependency_injection/dependency_injection.dart';

class AppInit {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // await _initFirebase();
    await _initDependencyInjection();
  }

  // 🔥 Firebase Init
  // static Future<void> _initFirebase() async {
  //   await Firebase.initializeApp();
  // }

  // 📦 GetIt Init
  static Future<void> _initDependencyInjection() async {
    await DependencyInjection.init();
  }
}