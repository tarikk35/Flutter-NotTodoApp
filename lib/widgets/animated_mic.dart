import 'package:flutter/material.dart';
import 'package:ntd_app/models/scoped_ntd.dart';
import 'package:scoped_model/scoped_model.dart';

class AnimatedMic extends StatelessWidget {
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Column(
        children: [
          AnimatedCrossFade(
            duration: Duration(milliseconds: 800),
            firstChild: Container(
              height: 100,
              width: 80,
              child: IconButton(
                icon: Icon(
                  Icons.mic,
                  size: 60,
                  color: Colors.black,
                ),
                onPressed: () async {
                  model.changePath(await model.startRecording());
                  print(model.currRecordPath);
                },
              ),
            ),
            secondChild: Container(
              height: 100,
              width: 80,
              child: IconButton(
                icon: Icon(
                  Icons.mic,
                  size: 60,
                  color: Colors.red,
                ),
                onPressed: () {
                  model.stopRecording();
                },
              ),
            ),
            crossFadeState: model.isRecording
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
          Text(model.recorderTxt),
        ],
      ),
    );
  }
}
