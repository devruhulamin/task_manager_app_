import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultBackGround extends StatelessWidget {
  const DefaultBackGround({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/svg/background.svg',
          width: double.infinity,
          height: double.infinity,
        ),
        child,
      ],
    );
  }
}
