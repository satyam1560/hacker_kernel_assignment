import 'package:flutter/material.dart';
import 'package:hacker_kernel_assignment/src/config/shared_prefs.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/presentation/pages/login_screen.dart';
import 'package:hacker_kernel_assignment/src/features/products/presentation/pages/list_products_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const name = 'SplashScreen';
  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        final token = SharedPrefs.getToken();

        if (token != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ListProductScreen()));
        } else {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hacker Kernel',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
