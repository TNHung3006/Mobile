import 'package:flutter/material.dart';
import 'package:ngoc_hung66131218_flutter_app/form/form_model.dart';
import 'form_model.dart';

class PageFormMathang extends StatelessWidget {
  PageFormMathang({super.key});
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtSoluong = TextEditingController();
  MatHang m = MatHang();
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Demo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                controller: txtName,
                onSaved: (newValue) => m.name = newValue,
                validator: (value) => validateString(value),
                decoration: InputDecoration(
                  labelText: "Ten mat hang"
                ),
              ),
              DropdownButtonFormField<String>(
                items: loaiMHs.map((loaiMH) => DropdownMenuItem<String>(child: Text("$loaiMH"),
                  value: loaiMH,
                )).toList(),
                onChanged: (value) => dropdownValue = value,
                onSaved: (newValue) => m.loaiMH = newValue,
                value: dropdownValue,
                validator: (value) => validateString(value),
                decoration: InputDecoration(
                  labelText: "Loai mat hang"
                ),
              ),
              TextFormField(
                controller: txtSoluong,
                keyboardType: TextInputType.number,
                onSaved: (newValue) => m.soluong = int.parse(newValue!),
                validator: (value) => validateSoluong(value),
                decoration: InputDecoration(
                  labelText: "So luong"
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => _save(context),
                    child: Text("Save")
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(BuildContext context) {
    if(formState.currentState!.validate()){
      formState.currentState!.save();
      hienThiDiaLog(context);
    }
  }
  validateString(String? value){
    return value == null || value.isEmpty ? "Ban chua nhap du lieu" : null;
  }
  validateSoluong(String? value){
    if(value == null || value.isEmpty)
      return "ban chua nhap so luong";
    else
      return int.parse(value) < 0 ? "so luong khong duoc phep nho hon 0!!" : null;
  }

  void hienThiDiaLog(BuildContext context) {
    var dialog = AlertDialog(
      title: Text("Thong bao"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Ban da nhap mat hang: "),
          Text("Ten MH: ${m.name}"),
          Text("Loai MH: ${m.loaiMH}"),
          Text("So luong MH: ${m.soluong}"),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("OK")
        )
      ],
    );
    showDialog(
      context: context,
      builder:(context) => dialog
    );
  }
}

