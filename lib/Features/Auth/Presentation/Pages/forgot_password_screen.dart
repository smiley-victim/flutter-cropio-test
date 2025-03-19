import 'package:flutter/material.dart';
import 'package:myapp/Features/Auth/Data/DataSource/authservice.dart';

import '../../../../Core/Constants/appconstants.dart';
import '../Widgets/signboard.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _otpController = TextEditingController();
  // final TextEditingController _newpasswordController = TextEditingController();
  bool isSwitched = false;
  //bool _showpassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 232, 253, 233),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, right: 150),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 50),
                  child: Signboard(text: 'forgot password')),
            ),
            s10,
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              'This is currently under\n active development 🚧',
              // style: GoogleFonts.inter(fontSize: 20),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
              child: TextField(
                key: const ValueKey("Name_textfield"),
                // style: GoogleFonts.inter(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                magnifierConfiguration:
                    TextMagnifier.adaptiveMagnifierConfiguration,
                controller: _emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 79, 79, 80)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 79, 79, 80)),
                    ),
                    focusColor: const Color.fromARGB(255, 28, 28, 29),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onTertiaryFixed,
                    border: const OutlineInputBorder(
                        gapPadding: 0,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: "Email",
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    hintText: "Enter your Email",
                    hintStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400)),
                // onChanged: (value) => _name,
              ),
            ),
            
            const SizedBox(height: 16.0),
            ElevatedButton(
                style: ButtonStyle(
                    enableFeedback: true,
                    maximumSize: WidgetStateProperty.all(const Size(250, 60)),
                    minimumSize: WidgetStateProperty.all(const Size(250, 60)),
                    visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onTertiaryFixed)),
                onPressed: () async{
                  if(_emailController.text.trim().isNotEmpty){
                  String message =  await AuthServiceImpl().forgotPassword(_emailController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        message,
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Please Enter Valid Email",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                    ));
                  },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ))
          ],
        ));
  }
}
