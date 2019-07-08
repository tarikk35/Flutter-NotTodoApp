import 'package:flutter/material.dart';

import 'package:ntd_app/widgets/gradient_container.dart';
import 'package:ntd_app/widgets/card_list.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Align(
        alignment: Alignment(0, 0),
        child: CardList(),
      ),
    );
  }
}
