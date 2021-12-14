import 'package:firebase_core/firebase_core.dart';
import 'package:flutfire/getx_app/app.dart';
// import 'package:flutfire/provider_app/app.dart';
// import 'package:flutfire/setState/app.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'provider_app/counter/counterProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyGetApp());

  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (_) => CounterProvider()),

  //   ],
  //   child: ProviderApp(),
  // ));

  // runApp(SetStateApp());
}
