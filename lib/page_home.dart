import 'package:flutter/material.dart';
import 'package:ngoc_hung66131218_flutter_app/Test-gk/mau/baiontap/tinhtoan.dart';
import 'package:ngoc_hung66131218_flutter_app/Test-gk/thi-gk-test.dart';
import 'package:ngoc_hung66131218_flutter_app/app_state_ex/getx/page_getx.dart';
import 'package:ngoc_hung66131218_flutter_app/bai_giang/listview.dart';
import 'package:ngoc_hung66131218_flutter_app/model/page_fruit.dart';
import 'package:ngoc_hung66131218_flutter_app/model/page_fruit_stream.dart';
import 'package:ngoc_hung66131218_flutter_app/profile/page_profile_v2.dart';
import 'package:ngoc_hung66131218_flutter_app/profile/profile.dart';
import 'package:ngoc_hung66131218_flutter_app/rss/pages/page_rss.dart';

class PageHome extends StatelessWidget { //0 st ->> stless
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(  //1
      appBar: AppBar( //2
        title: Text("My App"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column( //3 theo chiều dọc // đặt chuột vào column -> dấu bóng đèn -> wrap with center // để đưa vào giữa
          children: [
            _buildButton(context, title: "My profile", destination: MyProfile()),
            _buildButton(context, title: "My profile v2", destination: PageProfileV2()),
            _buildButton2(context, title: "Second pages", destination: PageSecond()),
            _buildButton2(context, title: "Fruit store", destination: PageListView()),
            _buildButton2(context, title: "GetXApp", destination: GetxApp()),
            _buildButton2(context, title: "Rss", destination: PageRss()),
            _buildButton2(context, title: "Fruit Supabase", destination: PageFruitStream()),
            _buildButton2(context, title: "Fruit Supabase2", destination: PageFruit()),
            _buildButton2(context, title: "Page GK", destination: PageGKTest()),
            _buildButton2(context, title: "Page GK mau", destination: MainPage()),
          ],
        ),
      ),
    );
  }
  Widget _buildButton(BuildContext context, {required String? title, required Widget? destination}){
    return Container(
      width: 200,
      child: ElevatedButton( //4 // -> đặt chuột vào bóng đèn ->> Container bọc lại
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.purple[50]),
              elevation:  WidgetStateProperty.all(2)
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => destination!,)); //5 để bấm vào chạy qua trang profile, //them ! de bao ke // push de chuyen toi trang duong dan, pop de quay ve
          },
          child: Text(title!) //them ! de bao ke
      ),
    );
  }
  Widget _buildButton2(BuildContext context, {required String? title, required Widget? destination}){
    return Container(
      width: 200,
      child: ElevatedButton( //4 // -> đặt chuột vào bóng đèn ->> Container bọc lại
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.purple[50]),
              elevation:  WidgetStateProperty.all(2)
          ),
          onPressed: () async{
            var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => destination!,)); //5 để bấm vào chạy qua trang profile, //them ! de bao ke // push de chuyen toi trang duong dan, pop de quay ve
            if(result!=null){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("da nhan li xi 50k"))
              );
            }
          },
          child: Text(title!) //them ! de bao ke
      ),
    );
  }
}

class PageSecond extends StatelessWidget {
  const PageSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop("Li xi tet 50k"); // quay lai trang truoc
          },
          child: Text("Go back")
        ),
      ),
    );
  }
}
