import 'package:flutter/widgets.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    await GoogleSignIn.instance.initialize();
  }

  // 📦 GetIt Init
  static Future<void> _initDependencyInjection() async {
    await DependencyInjection.init();
  }
}
