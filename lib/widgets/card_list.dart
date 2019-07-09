import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ntd_app/services/sound_ops.dart';
import 'package:ntd_app/widgets/play_btn.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ntd_app/models/scoped_ntd.dart';
import 'package:ntd_app/models/ntd_model.dart';

class CardList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CardListState();
  }
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => model.items.length > 0
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              height: MediaQuery.of(context).size.height * 5 / 7,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.1), color: Colors.black12),
              child: ListView(
                children: model.items
                    .map(
                      (item) => Tile(
                        // our special list tile widget
                        item: item,
                      ),
                    )
                    .toList(),
              ),
            )
          : Center(
              child: Text(
                'There\'s nothing to show.',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
    );
  }
}

class Tile extends StatefulWidget {
  final NotTodo item;
  Tile({this.item});
  @override
  State<StatefulWidget> createState() {
    return _TileState();
  }
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Dismissible(
        key: Key(widget.item.record),
        direction: DismissDirection.endToStart,
        background: Container(
          // seen when sliding but only a simple static icon
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 40),
          color: Colors.redAccent,
          child: Icon(Icons.delete_sweep),
        ),
        onDismissed: (direction) {
          setState(() {
            model.removeNTD(widget.item.id);
          });
          model.unselectItem();
          if (model.playStatus == PlayStatus.Playing) {
            model.stopPlayer();
          }
        },
        child: Card(
          color: Colors.white,
          child: AnimatedContainer(
            height: model.selectedItem == widget.item ? 120 : 80,
            child: ListTile(
              onTap: () {
                if (model.selectedItem == widget.item) {
                  model.unselectItem();
                  model.playStatus == PlayStatus.Playing
                      ? model.stopPlayer()
                      : {};
                } else {
                  model.selectItem(widget.item);
                }
              },
              trailing: IconButton(
                icon: Icon(Icons.star),
                color: Colors.yellow.shade700,
                onPressed: () {},
              ),
              leading: Icon(
                Icons.directions_run,
                color: Colors.green,
                size: 34,
              ),
              title: Text(
                widget.item.title,
                style: TextStyle(fontSize: 21),
              ),
              subtitle: AnimatedCrossFade(
                duration: Duration(milliseconds: 300),
                firstChild: Row(
                  children: <Widget>[
                    PlayButton(uri: widget.item.record),
                    Text(widget.item.details),
                  ],
                ),
                secondChild: Container(),
                crossFadeState: model.selectedItem == widget.item
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
            duration: Duration(milliseconds: 400),
          ),
        ),
      ),
    );
  }
}
