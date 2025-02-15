import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Core/Get_it/get_it.dart';
// import 'package:myapp/Features/Auth/Presentation/Pages/auth_page.dart';
import 'package:myapp/Features/Auth/Presentation/Pages/onboarding_page.dart';
import 'package:myapp/Features/Auth/Presentation/bloc/auth_bloc.dart';
import 'package:myapp/Features/Reminder/Presentation/bloc/reminder_bloc.dart';

import 'Features/Reminder/Domain/plantevent_service.dart';

void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await PlantEventService().initializeDefaultEvents();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
         BlocProvider(
          create: (context) => ReminderBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Alpha Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 28, 73, 31)),
        ),
        home: const OnboardingPage(),
      ),
    );
  }
}
