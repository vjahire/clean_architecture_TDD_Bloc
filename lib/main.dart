import 'package:clean_architecture_tdd_bloc/src/core/services/injection_container.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //First insure you initialised everything
  WidgetsFlutterBinding.ensureInitialized();

  //Init dependency injection
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Placeholder(),
    );
  }
}
