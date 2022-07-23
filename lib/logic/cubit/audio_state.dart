part of 'audio_cubit.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

class AudioOn extends AudioState {
  @override
  String toString() {
    return 'On';
  }
}

class AudioOff extends AudioState {
  @override
  String toString() {
    return 'Off';
  }
}
