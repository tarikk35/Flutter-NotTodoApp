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
  - Swipe için : Yeni Achievement sayfası ekle ve sağa swap edilirse completed-achieved - sola swap edilirse edit olsun.
  - Sağa swap edilirken star seçiliyse achieved, seçilmediyse deleted olsun.
  - Priority olsun ve icon rengi priority ile belirlensin, veritabanına priority int eklensin ve enum priority sağlansın.
  - Sağdaki sayfa için Achieved count - deleted count özellikleri eklensin.
  - ListTile'ın en sağındaki yıldız animasyonu ve state'i eklensin ve sağa atıldığı zaman yıldıza göre durumu değişsin.
  - Veritabanına Starred bit özelliği eklensin.
  - Yazı giriş sınırı getirilebilir.
  - Update yapılırken active bit'i değişmiyor fixle.
  - Yazıları handle etmek için wrap kullan ve layout'u tamamen değiştir.
     */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColorBrightness: Brightness.light,
            primarySwatch: Colors.blue),
        title: 'Not-To-Do',
        debugShowCheckedModeBanner: false,
        home: PageViewer(),
      ),
    );
  }
}
