import 'package:flutter/material.dart';
import 'package:onlineprep/view/signin_detector.dart';
import 'package:onlineprep/view/signup_page.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: 80,
            left: MediaQuery.of(context).size.width * 0.15,
            right: MediaQuery.of(context).size.width * 0.15,
            bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _welcomeText(),
                  const SizedBox(height: 50),
                  _emailTextField(context),
                  _passwordTextField(context),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () async => await _loginApiCall(context),
                    child: _signInButton(context),
                  ),
                  const SizedBox(height: 20),
                  const Text("Forget Password?"),
                ],
              ),
              const SizedBox(height: 15),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
                  },
                  child: const Text("New here? Sign up instead"))
              //TextButton(onPressed: () {}, child: Text("SignIn"))
            ],
          ),
        ),
      ),
    );
  }

  Text _welcomeText() {
    return const Text(
      "Hello there ,\nWelcome Back",
      style: TextStyle(fontSize: 26),
    );
  }

  TextFormField _emailTextField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(labelText: "EMAIL ADDRESS"),
      obscureText: false,
      //validator: signInProvider.validatorFuction,
    );
  }

  TextFormField _passwordTextField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(labelText: "PASSWORD"),
      obscureText: true,
      //validator: signInProvider.validatorFuction,
    );
  }

  Future<void> _loginApiCall(BuildContext context) async {
    context.read<AuthViewModel>().setIsLoading(true);
    String email = _emailController.text;
    String password = _passwordController.text;
    bool islogin =
        await context.read<AuthViewModel>().getLoginToken(email, password);
    if (islogin == true && context.mounted) {
      // context.read<UserDataViewModel>().userId.isEmpty
      //     ? context.read<UserDataViewModel>().getUserdata()
      //     : null;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const SignInDetector())));
      context.read<AuthViewModel>().setIsLoading(false);
    } else {
      //context.read<AuthViewModel>().setSucess(false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color(0xFF494949),
            content: Text(
              'Incorrect Username or Password',
              style: TextStyle(color: Color(0xff03dac6)),
            )));
        context.read<AuthViewModel>().setIsLoading(false);
      }
    }
  }

  Container _signInButton(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xfff969798)),
      child: Center(
          child: context.watch<AuthViewModel>().isLoading
              ? const CircularProgressIndicator()
              : const Text(
                  "SIGN IN",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                )),
    );
  }
}
