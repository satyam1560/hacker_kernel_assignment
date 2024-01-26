import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_kernel_assignment/injection.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/presentation/widgets/custom_button.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/presentation/widgets/text_field_widget.dart';
import 'package:hacker_kernel_assignment/src/features/products/presentation/pages/list_products_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authBloc = sl<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state.status == AuthenticationStateStatus.authenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ListProductScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 250,
                      child: Image.asset('assets/login.jpg'),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email ID',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?'),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      onPressed: _submit,
                      text: 'Login',
                      color: Colors.blue,
                      logo: '',
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(),
                        ),
                        Text(" OR "),
                        Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: () {},
                      text: 'Login with google',
                      color: Colors.grey[350]!,
                      logo: 'assets/google.png',
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('New to Login? Register'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(
        AuthLoggedIn(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
