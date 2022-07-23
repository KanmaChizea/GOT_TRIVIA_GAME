import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/result_handler.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalScore = context.read<ResultHandlerCubit>().state.correct;
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
        height: 150,
        width: 150,
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey.shade300,
          color: totalScore >= 5 ? green : red,
          strokeWidth: 10,
          value: totalScore / 10,
        ),
      ),
      Text(
        '$totalScore/10',
        style: result,
      )
    ]);
  }
}
