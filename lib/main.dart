import 'package:flutter/material.dart';
import 'package:got_trivia_game/screens/home.dart';
import 'package:got_trivia_game/services/database/database.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<MyDatabase>(
      create: (context) => MyDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black87),
        home: const Home(),
      ),
    );
  }
}
