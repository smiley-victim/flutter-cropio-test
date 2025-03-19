import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Core/Get_it/get_it.dart';
import 'package:myapp/Features/Auth/Presentation/Pages/onboarding_page.dart';



void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  setupAndInitDependencies();
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alpha Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 28, 73, 31)),
      ),
      home: const OnboardingPage(),
    );
  }
}
