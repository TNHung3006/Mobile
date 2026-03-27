import 'package:flutter/material.dart'; //stful

class UIExample extends StatefulWidget {
  const UIExample({super.key});

  @override
  State<UIExample> createState() => _UIExampleState();
}

class _UIExampleState extends State<UIExample> {
  var txtName = TextEditingController(); // khai báo controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App hoa hau"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(), // dấu 3 gạch 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // sắp xep theo chiều ngang
            children: [
              Center(
                child: Container(
                  child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPPtlnYb_tpek-3vjmjOGpoRf2D7YvRYO6KQ&s")
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange,),
                  Icon(Icons.star, color: Colors.orange,),
                  Icon(Icons.star, color: Colors.orange,),
                  Icon(Icons.star, color: Colors.orange,),
                  Icon(Icons.star_half, color: Colors.orange,),
                  SizedBox(width: 30,),
                  Text("4.5" ,style: TextStyle(fontSize: 18),)
                ],
              ),
              Row(
                children: [
                  Expanded( // phân chia giao diện, flex chia giao diện theo mình muốn.
                    child: Container(
                      height: 100,
                      color: Colors.blue,
                      child: Text("Blue"),
                    ),
                  ),
                  Container( // nếu expanded ở đây thì width không có tác dụng, chỉ flex mới có
                    height: 100,
                    width: 80,
                    color: Colors.orange,
                    child: Text("Orange"),
                  ),
                ],
              ),
              TextField(
                controller: txtName,
                decoration: InputDecoration(
                  labelText: "Nhập tên bạn vào đây: "
                ),
                keyboardType: TextInputType.phone,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {

                        });
                      },
                      child: Text("Message")
                  ),
                ],
              ),
              Text("Xin Chào ${txtName.text}!")
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Đây là trang hoa hậu của tui!!"),
                duration: Duration(seconds: 3),
            )
          );
        },
      ),// cái nút dưới góc phải
    );
  }
}
