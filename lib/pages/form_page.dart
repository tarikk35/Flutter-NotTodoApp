import 'package:flutter/material.dart';
import 'package:ntd_app/models/ntd_model.dart';
import 'package:ntd_app/models/scoped_ntd.dart';
import 'package:ntd_app/widgets/animated_mic.dart';
import 'package:ntd_app/widgets/gradient_container.dart';
import 'package:ntd_app/widgets/form_textbox.dart';
import 'package:ntd_app/widgets/icon_flatbtn.dart';
import 'package:ntd_app/widgets/switch.dart';
import 'package:ntd_app/services/date_ops.dart';

class FormPage extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static final _titleController = TextEditingController();
  static final _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _changePage() {
      AppModel().unselectItem();
      FocusScope.of(context).requestFocus(new FocusNode());
      AppModel.controller.animateToPage(1,
          duration: Duration(milliseconds: 200), curve: Curves.easeInExpo);
    }

    bool _isEdit() {
      return AppModel().selectedItem != null ? true : false;
    }

    void _saveData() async {
      if (_formKey.currentState.validate() && !AppModel().isRecording) {
        NotTodo ntd;
        if (_isEdit()) {
          final item = AppModel().selectedItem;
          Map<String, dynamic> map = {
            'id': item.id,
            'title': _titleController.text,
            'details': _detailController.text,
            'creationdate': toStringDate(item.creationDate),
            'record':
                item.record == null ? AppModel().currRecordPath : item.record,
            'isactive': AppModel().isActive
          };
          ntd = NotTodo.fromMap(map);
          AppModel().updateNTD(ntd);
        } else {
          Map<String, dynamic> map = {
            'id': AppModel().items.length,
            'title': _titleController.text,
            'details': _detailController.text,
            'creationdate': toStringDate(
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day),
            ),
            'record': AppModel().currRecordPath,
            'isactive': AppModel().isActive
          };
          ntd = NotTodo.fromMap(map);
          AppModel().addNTD(ntd);
        }
        _changePage();
      }
    }

    return GradientContainer(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'Not To Do',
                style: TextStyle(
                    color: Colors.black, fontSize: 44, fontFamily: 'Kingsman'),
              ),
              centerTitle: true,
              floating: true,
              snap: true,
              elevation: 0,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 128,
                        ),
                        FormTextbox(
                          label: 'Thing I should not do / avoid',
                          controller: _titleController,
                          validationMsg:
                              'Please make sure you fill in the field.',
                          icon: Icon(Icons.do_not_disturb),
                          text:
                              _isEdit() ? AppModel().selectedItem.title : null,
                        ),
                        SizedBox(
                          height: 64,
                        ),
                        FormTextbox(
                            label: 'Details',
                            controller: _detailController,
                            validationMsg:
                                'Please make sure you fill in the field.',
                            icon: Icon(Icons.edit),
                            text: _isEdit()
                                ? AppModel().selectedItem.details
                                : null),
                        SizedBox(
                          height: 40,
                        ),
                        CustomSwitch(),
                        SizedBox(
                          height: 40,
                        ),
                        AnimatedMic(),
                        SizedBox(
                          height: 64,
                        ),
                      ],
                    ),
                  ),
                  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              iconFlatButton(
                _changePage,
                Colors.black54,
                Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              iconFlatButton(
                _saveData,
                Colors.black54,
                Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
