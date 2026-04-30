import 'package:flutter/widgets.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class AppInit {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initFirebase();
    await _initDependencyInjection();
  }

  // 🔥 Firebase Init
  static Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // 📦 GetIt Init
  static Future<void> _initDependencyInjection() async {
    await DependencyInjection.init();
  }
}
