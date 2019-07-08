import 'package:flutter/material.dart';
import 'package:ntd_app/pages/tab_viewer.dart';
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
  - NotTodo modeline bool achieved gibi bir property ekle.
  - Veritabanına achieved bit ekle.
  - Progress için birşeyler düşün.
  - Motive edici özellikler ekle.
  - Maskot ekle.
  - Renklerde değişime git.
  - Giriş/bilgilendirme ekranı yap.
  - ListTile'ın sol tarafı için Ikon seçme özelliği eklensin.
  - ListTile single tap yapılınca açılsın ve iconbutton kaldırılsın.
  - PageView controller'ı public static olmalı ve her yerden erişilip değiştirilebilmeli.
  - GradientContainer farklı gradyan renkleri olabilsin.  
  - İkon seçiminde rolling picking olabilir
  - Kaydedilen sesin uri'sini ntd ile ilişkilendir ve tarih-saate göre vs. isim ver.
  - Kaydedilen sesi silebil.
  - Ses kaydını değiştirebilme?.
  - Ses kaydı tamamlandıktan sonra Play-Pause ve Kare buton gelsin.
  - Ses kaydediliyorken kayıt olduğuna dair bir işaret verilsin.
  - Kayıt ediliyorken sayfalar arası gezinti yapılıyorsa itemi silme.
  - Tarih seçme özelliği ekle.
  - Seçilen ikonu arka planda göster?.
  - Aynı anda sadece bir adet list tile aktif kalabilsin veya aktif tile özelliğini kaldır.
  - Ekran tabview olabilir.
   */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: MaterialApp(
        title: 'Not-To-Do',
        debugShowCheckedModeBanner: false,
        home: TabViewer(),
      ),
    );
  }
}
