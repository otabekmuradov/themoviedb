import 'package:flutter/material.dart';
import 'package:themoviedb/navigation/main_navigation.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

enum MenuItem { login, signup }

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final textStyle = const TextStyle(fontSize: 18, color: Colors.black);
  bool _clr = true;
  bool _res = true;

  final _emailController = TextEditingController();
  String? errorEmail;

  void _email() {
    final email = _emailController.text;
    //Navigator.pushNamed(context, '/auth');

    if (email != '' && email.contains('@')) {
      errorEmail = null;
      Navigator.pushNamed(context, MainNavigationRouteNames.auth);
    } else {
      errorEmail = 'Email is required!';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final errorEmail = this.errorEmail;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              'assets/images/themoviedb_logo.png',
              height: 35,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18, top: 50, bottom: 10),
                child: Text(
                  'Resend activation email',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Text(
              "Missing your account verification email? Enter your email below to have it resent.",
              style: textStyle,
            ),
          ),
          const SizedBox(height: 30),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (errorEmail != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            errorEmail,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          ),
                        ),
                    ],
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(19),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Color.fromARGB(123, 0, 0, 0),
                          fontSize: 15,
                          letterSpacing: 1),
                      floatingLabelStyle: TextStyle(
                          color: Colors.blue, fontSize: 20, letterSpacing: 1),
                      hintText: 'What`s your email?',
                      hintStyle: TextStyle(color: Color.fromARGB(123, 0, 0, 0)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        borderSide:
                            BorderSide(color: Color.fromARGB(123, 0, 0, 0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _clr = !_clr;
                            _email();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 12),
                            backgroundColor: _clr
                                ? const Color.fromARGB(255, 0, 147, 193)
                                : const Color.fromARGB(255, 0, 11, 37),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text(
                          'Send',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              fontSize: 17),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _res = !_res;
                            Navigator.pushNamed(
                                context, MainNavigationRouteNames.auth);
                          });
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: _res
                                  ? const Color.fromARGB(255, 0, 147, 193)
                                  : const Color.fromARGB(255, 0, 11, 37),
                              fontSize: 17),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
