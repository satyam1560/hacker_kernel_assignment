import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_kernel_assignment/injection.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/presentation/pages/login_screen.dart';
import 'package:hacker_kernel_assignment/src/features/products/presentation/pages/list_products_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authBloc = sl<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: _authBloc,
      builder: (context, state) {
        if (state.status == AuthenticationStateStatus.authenticated) {
          return const ListProductScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
