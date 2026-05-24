import 'package:ngoc_hung66131218_flutter_app/model/supabase_helper.dart';

class GioHangItem{
  int? id;
  String? uid;
  int fruitId, soluong;
  bool chon;

  GioHangItem({
    this.id,
    this.uid,
    required this.fruitId,
    required this.soluong,
    required this.chon,
  });

  Map<String, dynamic> toMap() {
    return {
      // ĐÃ SỬA: Chỉ đưa 'id' vào map nếu nó không bị null
      if (this.id != null) 'id': this.id,
      'uid': this.uid,
      'fruitId': this.fruitId,
      'soluong': this.soluong,
      'chon': this.chon,
    };
  }

  factory GioHangItem.fromMap(Map<String, dynamic> map) {
    return GioHangItem(
      id: map['id'] as int,
      uid: map['uid'] as String,
      fruitId: map['fruitId'] as int,
      soluong: map['soluong'] as int,
      chon: map['chon'] as bool,
    );
  }
}

class GioHangItemSnapshot{
  static Future<Map<int, GioHangItem>> getGioHang(String filterColumn){
    return getMapDataFilter(
      table: "GioHang",
      filterColumn: filterColumn,
      filterValue: supabase.auth.currentUser?.id ?? "",
      fromJson: (map) => GioHangItem.fromMap(map),
      getID: (t) => t.fruitId,
    );
  }
  static Future<int> them(GioHangItem item) async{
    try{
      await supabase.from("GioHang").insert(item.toMap());
      return 1;
    }
    catch(e){
      print("Lỗi thêm vào giỏ hàng: ${e.toString()}");
      return 0;
    }
  }
  static Future<int> capNhat(GioHangItem item) async{
    try{
      await supabase.from("GioHang").update(item.toMap()).eq("uid", item.uid!).eq("fruitId", item.fruitId);
      return 1;
    }
    catch(e){
      print("Lỗi cập nhật vào giỏ hàng: ${e.toString()}");
      return 0;
    }
  }
}