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

  // ĐÃ SỬA: Tính tổng số lượng của từng món cộng lại thay vì đếm số dòng
  int get slMHG => gioHang.values.fold(0, (sum, item) => sum + item.soluong);

  @override
  void onReady() {
    super.onReady();
    FruitSnapshot.getMapFruit().then(
          (value) {
        mapFruits = value;
        update(['fruits']);
      },
    ).onError(
          (error, stackTrace) {
        debugPrint("Lỗi đọc bảng fruits: $error");
      },
    );

    if (supabase.auth.currentUser != null) {
      getGioHang();
    }
  }

  void getGioHang() {
    GioHangItemSnapshot.getGioHang("uid").then(
          (value) {
        gioHang = value;
        update(["gioHang"]);
      },
    ).onError(
          (error, stackTrace) {
        debugPrint("Lỗi đọc bảng giỏ hàng: $error");
      },
    );
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