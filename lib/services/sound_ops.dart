import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter_sound/flutter_sound.dart';

enum PlayStatus { Playing, Paused, Stopped }

mixin SoundOps on Model {
  final flutterSound = FlutterSound();

  String recorderTxt = '00:00:00';
  bool isRecording = false;
  PlayStatus playStatus = PlayStatus.Stopped;
  String currRecordPath = '';
  int playIndex = -1;
  String playerTxt = '00:00:00';

  void changePath(path) {
    currRecordPath = path;
  }

  startRecording() async {
    final _uri = await getApplicationDocumentsDirectory()
        .then((value) => join(value.path, generatePath()));
    String path = await flutterSound.startRecorder(_uri);
    flutterSound.onRecorderStateChanged.listen((e) {
      if (e != null) {
        DateTime date =
            new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
        isRecording = true;
        recorderTxt = txt.substring(0, 8);
        notifyListeners();
      }
    });
    print(path);
    return path;
  }

  String generatePath() {
    print(DateTime.now().millisecondsSinceEpoch.toString());
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  stopRecording() async {
    try {
      if (isRecording) {
        await flutterSound.stopRecorder();
        isRecording = false;
        notifyListeners();
      }
      resetTimer();
    } catch (e) {
      print(e);
    }
  }

  startPlayer(_uri, index) async {
    try {
      playIndex = index;
      await flutterSound.startPlayer(_uri);
      print('$playIndex $index');
      playStatus = PlayStatus.Playing;
      flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt());
          String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
          playerTxt = txt.substring(0, 8);
          notifyListeners();
        }
      }).onDone(() {
        playStatus = PlayStatus.Stopped;
        playIndex = -1;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  pausePlayer() async {
    try {
      if (playStatus == PlayStatus.Playing) {
        await flutterSound.pausePlayer();
        playStatus = PlayStatus.Paused;
        resetTimer();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  resumePlayer() async {
    try {
      if (playStatus == PlayStatus.Paused) {
        await flutterSound.resumePlayer();
        playStatus = PlayStatus.Playing;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> stopPlayer() async {
    try {
      await flutterSound.stopPlayer();
      playStatus = PlayStatus.Stopped;
      playIndex = -1;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  changePlayer(uri, index) async {
    try {
      await stopPlayer().then((_) async{
        await startPlayer(uri,index);
        playIndex=index;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  resetTimer() {
    recorderTxt = '';
    playerTxt = '';
    notifyListeners();
  }
}
