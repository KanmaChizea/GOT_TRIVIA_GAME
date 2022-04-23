import 'package:flutter/material.dart';
import 'package:got_trivia_game/services/trivia_processing.dart';

class CountdownTimer extends StatefulWidget {
  final int index;
  const CountdownTimer({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return '00:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _timeup() {
    if (countText == '00:00') {
      controller.stop();
      TriviaProcessing().answeredQuestion(widget.index, context, false);
    }
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    controller.addListener(() {
      _timeup();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.red,
                      strokeWidth: 4,
                      value: controller.value),
                ),
                Text(countText,
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
              ],
            ));
  }
}
