import 'package:flutter/material.dart';
import 'package:ngoc_hung66131218_flutter_app/model/fruit.dart';

class PageFruit extends StatelessWidget {
  const PageFruit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit Store Supabase 2"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea( // khử thanh cong cụ 3 nút phía dưới của đt
        child: FutureBuilder<Map<int, Fruit>>(
          future: FruitSnapshot.getMapFruit(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              print("loi quai`: ${snapshot.error.toString()}");
              return Center(
                child: Text("loi qai`..."),
              );
            }
            if(!snapshot.hasData){
              return Center(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Dang tai...")
                  ],
                ),
              );

            }
            var iterable = snapshot.data!.values.toList();
            return GridView.extent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 5,
              childAspectRatio: 0.7,
              children: iterable.map(
                  (e) {
                    return Column(
                      children: [
                        Image.network(e.anh?? "No image"),
                        Text(e.ten),
                        Text("${e.gia ?? 0}")
                      ],
                    );
                  } ,
              ).toList(),
            );
          },
        )
      ),
    );
  }
}
