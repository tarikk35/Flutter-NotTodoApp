import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ntd_app/models/scoped_ntd.dart';
import 'package:ntd_app/services/sound_ops.dart';

class PlayButton extends StatelessWidget {
  final uri, index;
  PlayButton({this.uri, this.index});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => IconButton(
        icon: Icon(
          model.playIndex == index && model.playStatus == PlayStatus.Playing
              ? Icons.pause
              : Icons.play_arrow,
          size: 32,
          color: Colors.white,
        ),
        onPressed: () {
          if (model.playStatus == PlayStatus.Playing &&
              model.playIndex == index) {
            model.pausePlayer();
          } else if (model.playStatus == PlayStatus.Paused) {
            model.resumePlayer();
          } else if (model.playStatus == PlayStatus.Playing &&
              model.playIndex != index) {
            model.changePlayer(uri, index);
          } else {
            model.startPlayer(uri, index);
          }
        },
      ),
    );
  }
}
