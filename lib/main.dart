import 'package:flutter/material.dart';
import 'package:ntd_app/pages/page_viewer.dart';
import 'package:ntd_app/services/db_ops.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/scoped_ntd.dart';

void main() async {
  await DatabaseHelper().db.then((_) => AppModel().fetchAll());
  runApp(MyApp());
}

/* TODO:
  - Uygulama ilk yüklendiği zaman yazı tipleri büyüklükleri gibi büyüklükler mediaquery'e göre ayarlansın.
  - List tile'ın başlığı ve detayları, yazı büyüdükçe otomatik ayarlansın. 
  - Not todo'nun detay giriş yapılan yeri multi-line desteklesin. 
  - Swipe için : Yeni Achievement sayfası ekle.
  - Progress için birşeyler düşün.
  - Motive edici özellikler ekle.
  - Maskot ekle.
  - Giriş/bilgilendirme ekranı yap.
  - ListTile'ın sol tarafı için Ikon seçme özelliği eklensin.
  - GradientContainer farklı sayfalarda farklı gradyan renkleri olsun.  
  - İkon seçiminde rolling picking olabilir
  - Kaydedilen sesi silebil.
  - Ses kaydediliyorken kayıt olduğuna dair bir işaret verilsin.
  - Tarih seçme özelliği ekle.
  - Seçilen ikonu detayları açınca göster ?.
  - Ekranı pageview horizontal'a dönüştür ve handle et.
  - Tabbar tarzı eklenti oluştur.
  - Draggable ve dragtarget widgetları oluştur.
     */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: MaterialApp(
        theme: ThemeData(primaryColorBrightness: Brightness.light,
        primarySwatch: Colors.blue),
        title: 'Not-To-Do',
        debugShowCheckedModeBanner: false,
        home: PageViewer(),
      ),
    );
  }
}
