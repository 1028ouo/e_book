import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInitialized = false;

  factory AudioService() {
    return _instance;
  }

  AudioService._internal();

  Future<void> initialize() async {
    if (!_isInitialized) {
      await _audioPlayer.setAsset('assets/magic_forest.mp3');
      await _audioPlayer.setLoopMode(LoopMode.all);
      _isInitialized = true;
    }
  }

  Future<void> play() async {
    if (!_isInitialized) {
      await initialize();
    }
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
