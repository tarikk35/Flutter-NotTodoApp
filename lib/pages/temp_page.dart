import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ntd_app/models/scoped_ntd.dart';
import 'package:ntd_app/widgets/my_animated_icon.dart';
import 'package:scoped_model/scoped_model.dart';

class TempPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TempPageState();
  }
}

class _TempPageState extends State<TempPage> {
  final Map<int, String> items = {
    0: '🤡',
    1: '😈',
    2: '💀',
    3: '👽',
    4: '💩',
    5: '🦀',
  };
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => Center(
              child: MyAnimatedIcon(
                beginningSize: 30,
                targetSize: 120,
                color1: Colors.indigo,
                color2: Colors.indigoAccent,
                icon: Icons.whatshot,
              ),
            ),
        // builder: (context, child, model) => ReorderableListView(
        //   children: items.keys.map<Widget>((emoji) {
        //     return Container(
        //       child: Text(
        //         items[emoji],
        //         style: TextStyle(fontSize: 50),
        //       ),
        //       key: Key(items[emoji]),
        //       color: Colors.transparent,
        //     );
        //   }).toList(),
        //   onReorder: (int oldIndex, int newIndex) {
        //     setState(() {
        //       if (newIndex > oldIndex) {
        //         --newIndex;
        //       }
        //       final emoji = items[oldIndex];
        //       items[oldIndex] = items[newIndex];
        //       items[newIndex] = emoji;
        //     });
        //   },
        // ),
        );
  }
}

class Emoji extends StatelessWidget {
  Emoji({Key key, this.emoji}) : super(key: key);
  final String emoji;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        padding: EdgeInsets.all(10),
        child: Text(
          emoji,
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}
