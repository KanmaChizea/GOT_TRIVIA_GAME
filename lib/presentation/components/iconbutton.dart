import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/audio_cubit.dart';
import '../../utils/clicksound.dart';
import '../styles/colors.dart';

class MenuIconButtons extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final IconData secondaryIcon;
  const MenuIconButtons({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.secondaryIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: white, width: 2),
      ),
      child: IconButton(
        onPressed: () {
          playClick(context);

          onPressed();
        },
        color: white,
        icon: (icon == Icons.music_note)
            ? BlocBuilder<SoundCubit, AudioState>(builder: (context, state) {
                if (state is AudioOn) {
                  return Icon(icon);
                } else {
                  return Icon(secondaryIcon);
                }
              })
            : BlocBuilder<MusicCubit, AudioState>(builder: (context, state) {
                if (state is AudioOn) {
                  return Icon(icon);
                } else {
                  return Icon(secondaryIcon);
                }
              }),
        iconSize: 24,
      ),
    );
  }
}
