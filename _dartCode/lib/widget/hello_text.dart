import 'package:flutter/material.dart';

class HelloText extends StatelessWidget {
  final double fontSize;
  final bool isMobile;
  const HelloText({super.key, required this.fontSize, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.69),
      width: isMobile ? 560 : 860,
      height: isMobile ? 230 : 250,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "I am nondescript\n",
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontFamily: 'SourceCode',
            ),
            children: [
              TextSpan(
                  text: "flutter",
                  style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontFamily: 'SourceCode',
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: " developer",
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontFamily: 'SourceCode',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
