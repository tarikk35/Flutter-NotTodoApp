import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ntd_app/models/scoped_ntd.dart';
import 'package:scoped_model/scoped_model.dart';

class TempPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TempPageState();
  }
}

class _TempPageState extends State<TempPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Center(
        child: Text('hello world...'),
      ),
    );
  }
}
