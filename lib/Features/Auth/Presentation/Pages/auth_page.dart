// import 'package:flutter/material.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       if (constraints.maxWidth < 600) {
//         return const MobileAuthPage();
//       } else {
//         return const DesktopAuthPage();
//       }
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Features/Auth/Presentation/Pages/login_signup_page.dart';
import 'package:myapp/Features/Auth/Presentation/Widgets/auth_page_illustration.dart';

import '../../../Home/Presentation/Pages/responsive_homepage.dart';
import '../bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Error',
                style: TextStyle(color: Colors.red),
              ),
              content: Text(
                'Authentication failed. ${state.message}',
                style: TextStyle(color: Colors.black),
              ),
              // backgroundColor: Colors.green[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      const Text('OK', style: TextStyle(color: Colors.green)),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        }

        if (state is AuthSuccess) {
          debugPrint(state.toString());
          //here navigator for next page => HomePage
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const ResponsiveHomepage()),
              (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return Scaffold(
          // Use the initialWidget or a Scaffold
          body: Column(
            children: [
              AuthPageIllustration(),
              Container(
                width: double.infinity,
                // color: Theme.of(context).colorScheme.onPrimaryContainer,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Session check-in ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Reflect on your experience',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "The best fertilizer for the world is the blood, sweat, and tears of the farmer.",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text(' Sign Up/Login ❤')),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                       
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResponsiveHomepage()));
                        },
                        child: Text(' Login as a Guest ')),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'By signing up, you agree to our ',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Terms and Conditions',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
