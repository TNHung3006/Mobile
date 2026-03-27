import 'package:flutter/material.dart';
import 'package:ngoc_hung66131218_flutter_app/page_home.dart';
import 'package:ngoc_hung66131218_flutter_app/profile/profile.dart';
import 'package:ngoc_hung66131218_flutter_app/uiex.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.purpleAccent),
      ),
      home: PageHome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {//quản lý trạng thái
      _counter++;
    });
  }

  void _decrementCounter(){
    setState(() {
      _counter--;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: .center,
          children: [
            Text("Đây là app đầu tiên của tôi!!", style: TextStyle(fontSize: 22),),
            const Text('Bấm vào nút dấu + để tăng giá trị:',style: TextStyle(fontSize: 24, color: Colors.green),),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("Xin thầy cho 10đ", style: TextStyle(fontSize: 24, color: Colors.red),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () => _decrementCounter(),
                    child: Text("-", style: TextStyle(fontSize: 30),)
                ),
                SizedBox(width: 20,), // cách ra
                ElevatedButton(onPressed: () => _incrementCounter(),
                    child: Text("+", style: TextStyle(fontSize: 30),)
                )
              ],
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
  //
  // @override
  // void initState(){
  //   super.initState();
  //   _Counter = 10;
  // }