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
      id: map['id'] as int,
      gia: map['gia'] as int?,
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
}