import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/core/app_widget.dart';
import 'firebase_options.dart' as firebase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: firebase.DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppWidget());
}

