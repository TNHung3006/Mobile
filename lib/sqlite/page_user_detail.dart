import 'package:flutter/material.dart';
import 'package:ngoc_hung66131218_flutter_app/sqlite/provider_data.dart';
import 'package:ngoc_hung66131218_flutter_app/sqlite/sqlite_data.dart';
import 'package:provider/provider.dart';

import '../helpers/dialogs.dart';

class PageUserSQLiteDetail extends StatefulWidget {
  bool? xem;
  User? user;
  PageUserSQLiteDetail({super.key, this.xem, this.user});

  @override
  State<PageUserSQLiteDetail> createState() => _PageUserSQLiteDetailState();
}

class _PageUserSQLiteDetailState extends State<PageUserSQLiteDetail> {

  bool? xem;
  User? user;
  String title = "Thong tin User";
  String buttonTitle = "Dong";
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: txtTen,
                decoration: const InputDecoration(
                  label: Text("Ten: ")
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: txtPhone,
                decoration: const InputDecoration(
                  label: Text("Phone: "),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: txtEmail,
                decoration: const InputDecoration(
                  label: Text("Email: "),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => _capNhat(context),
                    child: Text(buttonTitle),
                  ),
                  const SizedBox(width: 10,),
                  xem == true ? const SizedBox(width: 1,) :
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Dong"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    xem = widget.xem;
    user = widget.user;

    if(user != null) {
      if(xem != true){
        buttonTitle = "Cap nhat";
        title = "Chinh sua thong tin";
      }
      txtTen.text = user!.name!;
      txtPhone.text = user!.phone!;
      txtEmail.text = user!.email!;
    }
    else{
      buttonTitle = "them";
      title = "Them User";
    }
  }

  _capNhat (BuildContext context) async {
    if (xem == true) {
      Navigator.of(context).pop();
    }
    else {
      DatabaseProvider provider = context.read<DatabaseProvider>();
      User nUser = User(
          name: txtTen.text,
          phone: txtPhone.text,
          email: txtEmail.text
      );
      if (user == null) { // Thêm mới
        int id = -1;
        id = await provider.insertUser(nUser);
        if (id > 0) {
          showSnackBar(context, "Đa thêm ${nUser.name}", 3);
        } else {
          showSnackBar(context, "Them ${nUser.name} khong thanh cong", 3);
        }
      }
      else { // Cập nhật dữ liệu
        int count = 0;
        count = await provider.updateUser(nUser, user !.id!);
        if (count > 0) {
          showSnackBar(context, "Đa cap nhat ${user !.name!}", 3);
        } else {
          showSnackBar(context, "Cap nhat ${user !.name! } khong thành công", 3);
        }
      }
    }
  }
}

