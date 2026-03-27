
import 'dart:math';

import 'package:flutter/material.dart';

var data = [
  "Chuối", "Dừa", "Xoài", "Đào", "Lê", "Thị", "Mận", "Hồng", "Sầu ghiêng", "Ổi", "Mít", "Chanh", "Ớt", "Dưa hấu", "Sung"
];

class PageListView extends StatelessWidget {
  const PageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit store"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]),
            trailing: Text("${Random().nextInt(100)} kg"),
            subtitle: Text("Gia ${Random().nextInt(100)}.000 đồng"),
            leading: Image.network("https://images.everydayhealth.com/images/2025/can-you-eat-too-much-fruit-1440x810.jpg?w=508"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bạn chọn: ${data[index]}"))
              );
            },
          );
        },
        separatorBuilder: (context, index) => Divider(thickness: 1.5,),
        itemCount: data.length
      ),
    );
  }
}
