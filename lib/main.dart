import 'package:clean_arch_tdd_course/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia App',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 28),
          bodyMedium: TextStyle(fontSize: 20),
        ),
      ),
      home: const NumberTriviaPage(),
    );
  }
}
