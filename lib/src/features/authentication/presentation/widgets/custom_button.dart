import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? logo;
  final String text;
  final VoidCallback onPressed;
  final Color color;
  const CustomButton({
    Key? key,
    this.logo,
    required this.onPressed,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
        width: double.infinity,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              height: 20,
              width: 20,
              child: logo == '' ? const SizedBox() : Image.asset('$logo')),
          const SizedBox(width: 10),
          Text(text)
        ]),
      ),
    );
  }
}
