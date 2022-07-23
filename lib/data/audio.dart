import 'package:audioplayers/audioplayers.dart';

class AudioController {
  final String filename;
  AudioController({
    required this.filename,
  });

  AudioPlayer player = AudioPlayer();

  void play() {
    player.stop();
    player.play(AssetSource('audio/$filename'));
  }

  void stop() {
    player.stop();
  }

  void pause() {
    player.pause();
  }

  void resume() {
    player.resume();
  }

  void setplayback(double playbackRate) {
    player.setPlaybackRate(playbackRate);
  }

  void onComplete(Function(void)? action) {
    player.onPlayerComplete.listen((event) {
      action;
    });
  }

  void loop() {
    player.stop();
    player.play(AssetSource('audio/$filename'));
    player.setReleaseMode(ReleaseMode.loop);
  }
}
