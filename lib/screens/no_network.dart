import 'package:flutter/material.dart';
import 'package:got_trivia_game/screens/home.dart';
import 'package:got_trivia_game/services/trivia_controller.dart';
import 'package:got_trivia_game/styles/buttons.dart';
import 'package:got_trivia_game/styles/texts.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off_outlined,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 10),
            Text(
              "You don't have internet connection",
              style: body(),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const TriviaController()),
                  (route) => false),
              icon: const Icon(Icons.repeat_rounded),
              label: const Text('Try again'),
              style: elevatedButtonStyle(),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go back'),
              style: elevatedButtonStyle(),
            )
          ],
        ),
      ),
    );
  }
}
