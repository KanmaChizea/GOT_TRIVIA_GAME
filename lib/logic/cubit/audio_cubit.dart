import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:got_trivia_game/main.dart';
import 'package:hive/hive.dart';

part 'audio_state.dart';

getValue(Box box, String key) {
  var value = box.get(key);
  if (value == null) {
    throw Exception();
  } else {
    return value;
  }
}

class MusicCubit extends Cubit<AudioState> {
  MusicCubit() : super(AudioOn());

  late Box box;

  void initState() {
    bool? value;
    box = Hive.box('audio');
    try {
      value = getValue(box, 'music');
    } catch (e) {
      box.put('music', true);
      initState();
    }
    if (value!) musicController.loop();

    value ? emit(AudioOn()) : emit(AudioOff());
  }

  toggle() {
    bool value = box.get('music');
    value ? emit(AudioOff()) : emit(AudioOn());
    box.put('music', !value);
  }
}

class SoundCubit extends Cubit<AudioState> {
  SoundCubit() : super(AudioOn());

  late Box box;

  void initState() {
    bool? value;
    box = Hive.box('audio');
    try {
      value = getValue(box, 'sound');
    } catch (e) {
      box.put('sound', true);
      initState();
    }
    value! ? emit(AudioOn()) : emit(AudioOff());
  }

  toggle() {
    bool value = box.get('sound');

    value ? emit(AudioOff()) : emit(AudioOn());
    box.put('sound', !value);
  }
}
