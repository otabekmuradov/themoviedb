import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widget/auth_screen/auth_model.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

enum MenuItem { login, signup }

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: Scaffold(
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
        body: ListView(
          children: const [
            SizedBox(height: 25),
            _FormWidget(),
            _HeaderWidget(),
          ],
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});
  final bool _reg = true;
  final bool _vrf = true;

  final textStyle = const TextStyle(fontSize: 17, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18, top: 20, bottom: 10),
              child: Text(
                'Login to your account',
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
            'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. Click here to get started.',
            style: textStyle,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 280, top: 10),
          child: TextButton(
            onPressed: () {
              _reg == !_reg;
              Navigator.pushNamed(context, '/register_screen');
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: _reg
                      ? const Color.fromARGB(255, 0, 147, 193)
                      : const Color.fromARGB(255, 0, 11, 37),
                  fontSize: 17),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Text(
            "If you signed up but didn't get your verification email, click here to have it resent.",
            style: textStyle,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 245, top: 10),
          child: TextButton(
            onPressed: () {
              _vrf == !_vrf;
              Navigator.pushNamed(context, '/verify_screen');
            },
            child: Text(
              'Verify Email',
              style: TextStyle(
                  color: _vrf
                      ? const Color.fromARGB(255, 0, 147, 193)
                      : const Color.fromARGB(255, 0, 11, 37),
                  fontSize: 17),
            ),
          ),
        ),
      ],
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({super.key});
  @override
  Widget build(BuildContext context) {
    bool hidePass = context.read<AuthModel>().passHide;
    final onPressed = context.watch<AuthModel>().passHideFunc;

    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: Column(
          children: [
            const Row(
              children: [
                _ErrorMessageWidget(),
              ],
            ),
            TextFormField(
              controller: context.read<AuthModel>().loginTextController,
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
                hintStyle: TextStyle(color: Color.fromARGB(123, 0, 0, 0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  borderSide: BorderSide(color: Color.fromARGB(123, 0, 0, 0)),
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
              height: 25,
            ),
            const Row(
              children: [
                _ErrorMessageWidget(),
              ],
            ),
            TextFormField(
              controller: context.read<AuthModel>().passwordTextController,
              obscureText: hidePass,
              decoration: InputDecoration(
                labelText: 'password',
                labelStyle: const TextStyle(
                    color: Color.fromARGB(123, 0, 0, 0),
                    fontSize: 15,
                    letterSpacing: 1),
                floatingLabelStyle: const TextStyle(
                    color: Colors.blue, fontSize: 20, letterSpacing: 1),
                hintText: 'Enter your password!',
                hintStyle: const TextStyle(color: Color.fromARGB(123, 0, 0, 0)),
                contentPadding: const EdgeInsets.all(19),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  borderSide: BorderSide(color: Color.fromARGB(123, 0, 0, 0)),
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
                  onPressed: onPressed,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _AuthButtonWidget(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reset_screen');
                  },
                  child: const Text(
                    'Reset password',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 147, 193), fontSize: 17),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();
    final onPressed =
        model.canStartAuth == true ? () => model.auth(context) : null;
    final child = context.watch<AuthModel>().isAuthProgress == true
        ? const SizedBox(
            width: 50,
            height: 25,
            child: CircularProgressIndicator(),
          )
        : const Text(
            'Login',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                fontSize: 17),
          );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        backgroundColor: const Color.fromARGB(255, 0, 147, 193),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.watch<AuthModel>().errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red, fontSize: 14),
      ),
    );
  }
}
