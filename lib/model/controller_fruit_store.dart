import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ngoc_hung66131218_flutter_app/giohang/gio_hang.dart';
import 'package:ngoc_hung66131218_flutter_app/model/fruit.dart';
import 'package:ngoc_hung66131218_flutter_app/model/supabase_helper.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

var supabase = Supabase.instance.client;

class ControllerFruitStore extends GetxController {
  Map<int, Fruit> mapFruits = {};
  Map<int, GioHangItem> gioHang = {};

  int get slMHG => gioHang.values.fold(0, (sum, item) => sum + item.soluong);

  @override
  void onReady() {
    super.onReady();
    FruitSnapshot.getMapFruit().then((value) {
      mapFruits = value;
      update(['fruits']);
    }).onError((error, stackTrace) {
      debugPrint("Lỗi đọc bảng fruits: $error");
    });

    if (supabase.auth.currentUser != null) {
      getGioHang();
    }
  }

  void getGioHang() {
    if (supabase.auth.currentUser == null) return;
    GioHangItemSnapshot.getGioHang("uid").then((value) {
      gioHang = value;
      update(["gioHang"]);
    }).onError((error, stackTrace) {
      debugPrint("Lỗi đọc bảng giỏ hàng: ${error.toString()}");
    });
  }

  Future<void> dangXuat() async {
    await supabase.auth.signOut();
    gioHang.clear();
    update(["gioHang"]);
  }

  Future<void> dangNhap() async {
    getGioHang();
    update(["gioHang"]);
  }

  int tongTien() {
    int tong = 0;
    for (var item in gioHang.values) {
      if (item.chon == true) {
        tong += ((mapFruits[item.fruitId]!.gia ?? 0) * (item.soluong)).toInt();
      }
    }
    return tong;
  }

  Future<bool> themMH_vao_GH(Fruit f) async {
    if (gioHang.containsKey(f.id)) {
      gioHang[f.id]!.soluong += 1;
      var numUpdate = await GioHangItemSnapshot.capNhat(gioHang[f.id]!);
      if (numUpdate == 0) {
        gioHang[f.id]!.soluong -= 1;
      }
      update(["gioHang"]);
      return false;
    }

    GioHangItem item = GioHangItem(
      fruitId: f.id,
      uid: supabase.auth.currentUser!.id,
      soluong: 1,
      chon: true,
    );

    var num = await GioHangItemSnapshot.them(item);
    if (num == 1) {
      gioHang[f.id] = item;
      update(["gioHang"]);
    }
    return true;
  }
}