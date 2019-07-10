import 'package:flutter/material.dart';
import 'package:ntd_app/models/scoped_ntd.dart';

class CustomSwitch extends StatefulWidget {
  CustomSwitch();
  @override
  State<StatefulWidget> createState() {
    return _SwitchState();
  }
}

class _SwitchState extends State<CustomSwitch> {
  _SwitchState();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40,right: 40),
      child: SwitchListTile(
        activeColor: Colors.white,
        inactiveTrackColor: Colors.black26,
        inactiveThumbColor: Colors.grey,
        title: Text(
          'This is active',
          style: TextStyle(fontSize: 20,color: Colors.white70),
        ),
        value: AppModel().isActive,
        onChanged: (value) {
          setState(() {
            AppModel().isActive=value;
          });
        },
      ),
    );
  }
}
