import 'package:flutter/material.dart';
import 'package:onlineprep/view/login_page.dart';
import 'package:provider/provider.dart';

import '../viewmodel/auth_viewmodel.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
            bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _greetingText(),
              const SizedBox(height: 30),
              _nameTextFormField(),
              _emailTextFormField(),
              _passwordTextFormField(),

              const SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  context.read<AuthViewModel>().setIsLoading(true);
                  await _signUpApiCall(context);
                },
                child: _signUpButton(context),
              ),
              SizedBox(width: MediaQuery.of(context).size.height * 0.1),
              _navigateToLoginPageContainer(context)
              //TextButton(onPressed: () {}, child: Text("SignIn"))
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _passwordTextFormField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(labelText: "PASSWORD"),
      obscureText: true,
      //validator: signInProvider.validatorFuction,
    );
  }

  TextFormField _emailTextFormField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(labelText: "EMAIL ADDRESS"),
      obscureText: false,
      //validator: signInProvider.validatorFuction,
    );
  }

  TextFormField _nameTextFormField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(labelText: "NAME"),
      obscureText: false,
      //validator: signInProvider.validatorFuction,
    );
  }

  Align _greetingText() {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Get Started",
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  SizedBox _navigateToLoginPageContainer(BuildContext context) {
    return SizedBox(
        height: 40,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                child: const Text("Already a member?  sign in "))));
  }

  Container _signUpButton(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFF969798)),
      child: Center(
          child: context.watch<AuthViewModel>().isLoading
              ? const CircularProgressIndicator()
              : const Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                )),
    );
  }

  Future<void> _signUpApiCall(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String username = _nameController.text;
    Map data = {"username": username, "email": email, "password": password};

    bool isSignup = await context.read<AuthViewModel>().signUp(data) ?? false;
    if (isSignup == true && context.mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const LoginPage())));
      context.read<AuthViewModel>().setIsLoading(false);
    } else {
      //context.read<AuthViewModel>().setSucess(false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFF494949),
          content: Text(
            'incoorect data provided',
            style: TextStyle(color: Color(0xff03dac6)),
          )));
      context.read<AuthViewModel>().setIsLoading(false);
    }
  }
}
