import 'package:flutter/material.dart';
import 'package:ngoc_hung66131218_flutter_app/model/fruit.dart';

class PageFruitStream extends StatelessWidget {
  const PageFruitStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit store"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder(
        stream: FruitSnapshot.getFruitStream(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            print("Loi roi`" + snapshot.error.toString());
            return Center(
              child: Text("Loi roi`!!!", style: TextStyle(color: Colors.red),),
            );
          }
          if(!snapshot.hasData){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(), // hieu ung quay vong tron
                  Text("Dang tai...")
                ],
              ),
            );
          }
          List<Fruit> list = snapshot.data!;
          return  GridView.extent(
            maxCrossAxisExtent: 200, //
            childAspectRatio: 0.7,
            children: list.map(
              (e) {
                return Column(
                  children: [
                    Image.network(e.anh?? "No image"),
                    Text(e.ten),
                    Text("${e.gia?? 0}"),

                  ],
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
