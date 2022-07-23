import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/logic/cubit/audio_cubit.dart';

import '../../data/audio.dart';
import '../../logic/cubit/number_handler.dart';

class CountdownTimer extends StatefulWidget {
  final AnimationController controller;
  const CountdownTimer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late AnimationController transitionController;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return '00:${(10 - count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    transitionController = widget.controller;
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 10, end: 0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          context.read<NumberHandlerCubit>().nextQuestion();
          transitionController.reset();
          transitionController.forward();
        }
      });
    controller.forward();
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
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.red,
                    strokeWidth: 4,
                    value: animation.value / 10),
              ),
              Text(countText,
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
            ],
          );
        });
  }
}
