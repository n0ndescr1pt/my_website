import 'package:myWebsite/widget/game_of_life/game_of_life_widget.dart';
import 'package:myWebsite/widget/button.dart';
import 'package:myWebsite/widget/hello_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int width = 10;
  int height = 10;
  bool isFirstStart = true;
  @override
  Widget build(BuildContext context) {
    if (isFirstStart) {
      width = (MediaQuery.of(context).size.width / 5).toInt();
      height = (MediaQuery.of(context).size.height / 5).toInt();
      isFirstStart = false;
    }
    return MaterialApp(
      home: Scaffold(
        body: LayoutBuilder(
          builder: (ctx, constraints) {
            if (constraints.maxWidth > 820) {
              return Stack(
                children: [
                  GameOfLife(
                    rows: height,
                    columns: width,
                    cellSize: 5,
                  ),
                  webPresentation()
                ],
              );
            } else {
              return Stack(
                children: [
                  GameOfLife(
                    rows: height,
                    columns: width,
                    cellSize: 5,
                  ),
                  mobilePresentation()
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget webPresentation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const HelloText(fontSize: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              text: 'github',
              onPress: () async =>
                  await launchUrl("https://github.com/n0ndescr1pt"),
            ),
            const SizedBox(width: 22),
            MyButton(
              text: 'telegram',
              onPress: () async => await launchUrl("https://t.me/n0ndescr1pt"),
            ),
            const SizedBox(width: 22),
            MyButton(
              text: 'stackoverflow',
              onPress: () async => await launchUrl(
                  "https://stackoverflow.com/users/23530153/nondescript?tab=topactivity"),
            ),
          ],
        ),
      ],
    );
  }

  Widget mobilePresentation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const HelloText(fontSize: 37),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              isMobile: true,
              text: 'github',
              onPress: () async =>
                  await launchUrl("https://github.com/n0ndescr1pt"),
            ),
            const SizedBox(height: 22),
            MyButton(
              isMobile: true,
              text: 'telegram',
              onPress: () async => await launchUrl("https://t.me/n0ndescr1pt"),
            ),
            const SizedBox(height: 22),
            MyButton(
              isMobile: true,
              text: 'stackoverflow',
              onPress: () async => await launchUrl(
                  "https://stackoverflow.com/users/23530153/nondescript?tab=topactivity"),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> launchUrl(String url) async {
    await Future.delayed(const Duration(milliseconds: 421));
    await launchUrlString(url);
  }
}
