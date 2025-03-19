import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Core/Constants/appconstants.dart';
import 'package:myapp/Features/Auth/Data/DataSource/authservice.dart';
import 'package:myapp/Features/Auth/Presentation/Pages/forgot_password_screen.dart';
import 'package:myapp/Features/Home/Presentation/Pages/series_of_pages.dart';

import '../Widgets/signboard.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthServiceImpl obj = AuthServiceImpl();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 232, 253, 233),
        
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, right: 150),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 50),
                  child: Signboard(text: isSwitched ? 'Login' : 'Register')),
            ),
            s10,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Register',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              s10,
              CupertinoSwitch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
                activeTrackColor: const Color.fromARGB(255, 23, 122, 48),
                inactiveTrackColor: const Color.fromARGB(255, 23, 122, 48),
              ),
              s10,
              Text('Login',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              'This is currently under\n active development 🚧',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 25,
            ),
            !isSwitched
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                    child: TextField(
                      key: const ValueKey("Name_textfield"),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      magnifierConfiguration:
                          TextMagnifier.adaptiveMagnifierConfiguration,
                      controller: _nameController,
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
                          fillColor:
                              Theme.of(context).colorScheme.onTertiaryFixed,
                          border: const OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: "Name",
                          labelStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                          hintText: "Enter your Name",
                          hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      // onChanged: (value) => _name,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
              child: TextField(
                key: const ValueKey("Name_textfield"),
                style: TextStyle(color: Colors.white),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 28.0),
              child: TextField(
                key: const ValueKey("Name_textfield"),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.go,
                magnifierConfiguration:
                    TextMagnifier.adaptiveMagnifierConfiguration,
                controller: _passwordController,
                obscureText: true,
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
                    labelText: "password",
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400)),
                // onChanged: (value) => _name,
              ),
            ),
            Offstage(
              offstage: !isSwitched,
              child: TextButton(
                  onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ForgotPasswordScreen();
                      })),
                  child: Text('forgot password')),
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
                onPressed: () async {
                  if(isSwitched && _emailController.text.trim().isNotEmpty && _passwordController.text.trim().isNotEmpty){
                    String message = await obj.login(_emailController.text.trim(),
                          _passwordController.text.trim());
                    if (message.contains("Login Successfully")) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SeriesOfPages();
                    }));
                  } 
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        message,
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                    ));
 
                  }else if(_nameController.text.trim().isNotEmpty && 
                  _emailController.text.trim().isNotEmpty && 
                  _passwordController.text.trim().isNotEmpty){
                    String message = await obj.register(
                          _nameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text.trim());

                    if (message.contains("complete the registration.")) {
                    isSwitched = true;
                    setState(() {});
                  } 
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        message,
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                    ));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Please Enter All Valid Fields",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                    ));
                    return ;
                  }  
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      !isSwitched ? 'Sign Up' : 'sign in',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 05,
                    ),
                    Icon(
                      Icons.arrow_right_alt_sharp,
                      size: 25,
                      color: Colors.white,
                    )
                  ],
                ))
          ],
        ));
  }
}
