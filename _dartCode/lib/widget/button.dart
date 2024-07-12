import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class MyButton extends StatelessWidget {
  final void Function()? onPress;
  final String text;
  final bool isMobile;
  const MyButton(
      {super.key, this.onPress, required this.text, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      height: isMobile ? 50 : 70,
      width:  isMobile ? 180 : 200,
      text: text,
      isReverse: true,
      selectedTextColor: Colors.black,
      transitionType: TransitionType.LEFT_TO_RIGHT,
      backgroundColor: Colors.black,
      borderColor: Colors.white,
      borderRadius: 50,
      borderWidth: 2,
      onPress: onPress,
    );
  }
}
