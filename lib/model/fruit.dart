import 'package:ngoc_hung66131218_flutter_app/model/supabase_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//int count = 1;
class Fruit{
  int id;
  int? gia;
  String ten;
  String? moTa, anh;

  Fruit({
    required this.id,
    this.gia,
    required this.ten,
    this.moTa,
    this.anh,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'gia': this.gia,
      'ten': this.ten,
      'moTa': this.moTa,
      'anh': this.anh,
    };
  }

  factory Fruit.fromMap(Map<String, dynamic> map) {
    return Fruit(
      // Sử dụng num.parse hoặc kiểm tra kiểu để an toàn hơn
      id: map['id'] is int ? map['id'] as int : int.parse(map['id'].toString()),
      gia: map['gia'] != null
          ? (map['gia'] is int ? map['gia'] as int : int.parse(map['gia'].toString()))
          : null,
      ten: map['ten'] as String,
      moTa: map['moTa'] as String?,
      anh: map['anh'] as String?,
    );
  }

// Map<String, dynamic> toJson() {
//     return {
//       'id': this.id,
//       'gia': this.gia,
//       'ten': this.ten,
//       'moTa': this.moTa,
//       'anh': this.anh,
//     };
//   }
//
//   factory Fruit.fromJson(Map<String, dynamic> json) {
//     return Fruit(
//       id: json['id'] as int,
//       gia: json['gia'] as int?,
//       ten: json['ten'] as String,
//       moTa: json['moTa'] as String?,
//       anh: json['anh'] as String?,
//     );
//   }
//
}

class FruitSnapshot{
  static Stream<List<Fruit>> getFruitStream(){
    final supabase = Supabase.instance.client;
    var stream = supabase.from('Fruit').stream(primaryKey: ['id']);
    return stream.map(
      (event) => event.map((e) => Fruit.fromMap(e),).toList(),
    );
  }

  static Stream<List<Fruit>> getFruitStreamHTTT(){
    return  getDataStream<Fruit>(
      table: "Fruit",
      ids: ["id"],
      fromJson: (map) => Fruit.fromMap(map),
    );
  }

  static Future<Map<int, Fruit>> getMapFruit() async{
    // final data = await supabase.from('Fruit').select();
    // var iterable = data.map((e) => Fruit.fromMap(e),);
    // return Map.fromIterable(
    //   iterable,
    //   key: (element) => element.id,
    //   value: (element) => element,
    // );
    return getMapData(
      table: "Fruit",
      fromJson: (map) => Fruit.fromMap(map),
      getID: (t) => t.id,
    );
  }

  static Future<void> insert(Fruit f) async{
    await supabase
        .from('Fruit')
        .insert(f.toMap());
  }
  static Future<void> update(Fruit f) async{
    await supabase
        .from('Fruit')
        .update(f.toMap())
        .eq('id', f.id);
  }

  static listenFuitChange(Map<int, Fruit> maps, {Function()? updateUI}){
    // Gọi hàm dùng chung bên supabase_helper.dart
    listenDataChange<Fruit>(
      maps,
      updateUI: updateUI,
      channel: "public:fruit", // Nên viết liền không có dấu cách sau dấu hai chấm
      table: "Fruit",          // Lưu ý: Tên bảng trong Supabase của bạn viết hoa chữ F (như bạn viết ở trên)
      fromJson: (map) => Fruit.fromMap(map),
      getId: (f) => f.id,
    );
  }

  // static listenDataChange(Map<int, Fruit> maps,{Function()? updateUI}){
  //   supabase
  //       .channel('public:fruit')
  //       .onPostgresChanges(
  //       event: PostgresChangeEvent.all,
  //       schema: 'public',
  //       table: 'fruit',
  //       callback: (payload) {
  //         //print('Change received: ${payload.toString()}');
  //         switch(payload.eventType){
  //           case PostgresChangeEvent.insert:
  //           case PostgresChangeEvent.update:{
  //             Fruit f = Fruit.fromMap(payload.newRecord);
  //             maps[f.id] = f;
  //             updateUI?.call();
  //             break;
  //           }
  //           case PostgresChangeEvent.delete:{
  //             maps.remove(payload.oldRecord["id"]);
  //             updateUI?.call();
  //             break;
  //           }
  //           default:{}
  //         }
  //       })
  //       .subscribe();
  // }
}
