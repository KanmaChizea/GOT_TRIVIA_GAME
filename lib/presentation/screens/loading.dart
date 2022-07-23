import 'dart:async';

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late String loadingMessage;
  late Timer a, b;

  messageChange1() {
    setState(() {
      loadingMessage = '...experiencing some network delays';
    });
  }

  messageChange2() {
    setState(() {
      loadingMessage =
          '...please ensure you have a working internet connection';
    });
  }

  @override
  void initState() {
    loadingMessage = '...fetching questions';
    a = Timer(const Duration(seconds: 10), messageChange1);
    b = Timer(const Duration(seconds: 20), messageChange2);
    a;
    b;

    super.initState();
  }

  @override
  void dispose() {
    a.cancel();
    b.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(
              height: 10,
            ),
            Text(loadingMessage)
          ],
        ),
      ),
    );
  }
}
