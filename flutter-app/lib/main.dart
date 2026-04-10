import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'package:nexus/app.dart';
import 'package:nexus/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _bootstrapFirebase();
  await configureDependencies();
  runApp(const NexusApp());
}

Future<void> _bootstrapFirebase() async {
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase configuration can be added later without blocking mock flows.
  }
}
