import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                border: Border.all(width: 0.1),
                color: Colors.transparent,
              ),
              child: ListView(
                children: model.items
                    .map(
                      (item) => Tile(
                        // our special list tile widget
                        item: item,
                      ),
                    )
                    .toList(),
                shrinkWrap: true,
              ),
            )
          : Center(
              child: Text(
                'There\'s nothing to show.',
                style: TextStyle(color: Colors.white, fontSize: 24),
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
        confirmDismiss: (DismissDirection direction) async {
          bool result = direction == DismissDirection.endToStart ? false : true;
          if (!result) {
            AppModel().selectItem(widget.item);
            AppModel.controller.animateToPage(0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInExpo);
          }
          return result;
        },
        direction: DismissDirection.horizontal,
        background: Container(
          // seen when sliding but only a simple static icon
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 100),
          color: Colors.redAccent,
          child: Icon(
            Icons.delete_sweep,
            size: 44,
          ),
        ),
        secondaryBackground: Container(
          color: Colors.blue,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 100),
          child: Icon(
            Icons.mode_edit,
            size: 44,
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            setState(() {
              model.removeNTD(widget.item.id);
            });
            model.unselectItem();
            if (model.playStatus == PlayStatus.Playing) {
              model.stopPlayer();
            }
          } else {
            print('Safe in here, huh?');
          }
        },
        child: Card(
          elevation: 8,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Container(
            height: 100,
            color: Color.fromRGBO(58, 66, 86, 0.9),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              onTap: () {},
              trailing: IconButton(
                icon: Icon(Icons.star),
                color: Colors.yellowAccent.shade100,
                onPressed: () {},
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: Icon(
                  Icons.directions_run,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              title: Text(
                widget.item.title,
                style: TextStyle(fontSize: 21, color: Colors.white),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PlayButton(uri: widget.item.record,index: widget.item.id,),
                  Text(
                    DateFormat('yMMMMd').format(widget.item.creationDate),
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
