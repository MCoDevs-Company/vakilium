import 'package:flutter/material.dart';
import 'package:vakilium/src/common/constant/gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color(0xFF642FF4)],
                stops: [0, .5],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
              ),
            ),
            child: SizedBox.fromSize(
              size: Size.fromHeight(constraints.maxHeight * 0.6),
              child: Row(children: [Assets.icons.logo.svg()]),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: SizedBox.fromSize(size: Size.fromHeight(constraints.maxHeight * 0.8)),
            ),
          ),
        ],
      ),
    ),
  );
}
