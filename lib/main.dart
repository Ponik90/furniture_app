import 'package:flutter/material.dart';
import 'package:furniture_app/my_app.dart';

import 'init.dart';

Future<void> main() async {
  await AppInit.init();

  runApp(const MyApp());
}
