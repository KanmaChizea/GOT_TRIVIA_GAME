import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/audio_cubit.dart';
import '../main.dart';

playClick(BuildContext context) {
  if (context.read<SoundCubit>().state is AudioOn) {
    clickController.play();
  }
}
