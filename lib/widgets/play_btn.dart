import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ntd_app/models/scoped_ntd.dart';
import 'package:ntd_app/services/sound_ops.dart';

class PlayButton extends StatelessWidget {
  final uri;
  PlayButton({this.uri});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => IconButton(
        icon: Icon(
          model.playStatus == PlayStatus.Playing
              ? Icons.pause
              : Icons.play_arrow,
          size: 32,
          color: Colors.white,
        ),
        onPressed: () {
          if (model.playStatus == PlayStatus.Playing) {
            model.pausePlayer();
          } else if (model.playStatus == PlayStatus.Paused) {
            model.resumePlayer();
          } else {
            model.startPlayer(uri);
          }
        },
      ),
    );
  }
}
