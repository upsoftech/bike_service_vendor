

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

class RingService {


  static final player = AudioPlayer();


  static Future<void> playSirenSound() async {

    await player.play(AssetSource("audios/ring.mp3"));
  }

  static Future<void> stopSirenSound() async {
    try {
      await player.stop();
      log("kjiogoinboibnoibnnibi");
    } catch (e) {
      print("Error stopping audio player: $e");
    }
  }
}