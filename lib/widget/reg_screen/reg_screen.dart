import 'package:flutter/material.dart';
import 'package:themoviedb/navigation/main_navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RregisterScreenState();
}

enum MenuItem { login, signup }

class RregisterScreenState extends State<RegisterScreen> {
  final textStyle = const TextStyle(fontSize: 18, color: Colors.black);
  bool hidePass = true;
  bool _clr = true;
  bool _res = true;

  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _emailController = TextEditingController();
  final _passConfirmController = TextEditingController();
  String? errorEmail;
  String? errorUser;
  String? errorPass;
  String? errorConfPass;

  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;
    final email = _emailController.text;
    final passConf = _passConfirmController.text;

    if (login == '') {
      errorUser = 'Wrong username!';
    } else {
      errorUser = null;
    }

    setState(() {});

    if (password == '') {
      errorPass = 'Wrong password!';
    } else {
      errorPass = null;
    }

    setState(() {});

    if (passConf != password) {
      errorConfPass = 'The passwords do not match!';
    } else {
      errorConfPass = null;
    }

    setState(() {});

    if (email != '' && email.contains('@')) {
      errorEmail = null;
    } else {
      errorEmail = 'Email is required!';
    }

    setState(() {});

    if (errorUser == null &&
        errorPass == null &&
        errorEmail == null &&
        errorConfPass == null) {
      Navigator.pushReplacementNamed(
          context, MainNavigationRouteNames.mainScreen);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final errorUser = this.errorUser;
    final errorPass = this.errorPass;
    final errorConfPass = this.errorConfPass;
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
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18, top: 20, bottom: 10),
                  child: Text(
                    'Sign up for an account',
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
                "Signing up for an account is free and easy. Fill out the form below to get started. JavaScript is required to to continue.",
                style: textStyle,
              ),
            ),
            const SizedBox(height: 10),
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (errorUser != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              errorUser,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                    TextFormField(
                      controller: _loginTextController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(19),
                        labelText: 'username',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(123, 0, 0, 0),
                            fontSize: 15,
                            letterSpacing: 1),
                        floatingLabelStyle: TextStyle(
                            color: Colors.blue, fontSize: 20, letterSpacing: 1),
                        hintText: 'Write your username!',
                        hintStyle:
                            TextStyle(color: Color.fromARGB(123, 0, 0, 0)),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        if (errorPass != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              errorPass,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                    TextFormField(
                      controller: _passwordTextController,
                      obscureText: hidePass,
                      maxLength: 8,
                      decoration: InputDecoration(
                        labelText: 'password(4 characters minimum)',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(123, 0, 0, 0),
                          fontSize: 15,
                        ),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.blue, fontSize: 20),
                        hintText: 'Enter your password!',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(123, 0, 0, 0)),
                        contentPadding: const EdgeInsets.all(19),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          borderSide:
                              BorderSide(color: Color.fromARGB(123, 0, 0, 0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.only(right: 19),
                          icon: Icon(
                            hidePass ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (errorConfPass != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              errorConfPass,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                    TextFormField(
                      controller: _passConfirmController,
                      obscureText: hidePass,
                      decoration: InputDecoration(
                        labelText: 'Password Confirm',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(123, 0, 0, 0),
                          fontSize: 15,
                        ),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.blue, fontSize: 20),
                        contentPadding: const EdgeInsets.all(19),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          borderSide:
                              BorderSide(color: Color.fromARGB(123, 0, 0, 0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.only(right: 19),
                          icon: Icon(
                            hidePass ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                        hintStyle:
                            TextStyle(color: Color.fromARGB(123, 0, 0, 0)),
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
                              _auth();
                              _clr = !_clr;
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
                            'Sign Up',
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
                              Navigator.pushNamed(context, MainNavigationRouteNames.auth);
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
      ),
    );
  }

  // String? _validateEmail(String? value) {
  //   if (value!.isEmpty) {
  //     return 'Email cannot be empty';
  //   } else if (!_emailController.text.contains('@')) {
  //     return 'Invalid email address';
  //   } else {
  //     return null;
  //   }
  // }
}
