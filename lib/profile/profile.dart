import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  DateTime ngaySinh = DateTime(2005, 2, 14);
  String? gioiTinh = "Nữ";
  List<String> nnlts = [
    "Tiếng Việt",
    "No Language",
    "JAVA",
    "C++",
    "C#",
    "Python"
  ];
  String? nnlt = "No Language";

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ngọc Hùng Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Tran Ngoc Hung"),
              accountEmail: Text("hungtn@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("asset/images/thien_nhien.jpg"),
              ),
            ),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: () {
                setState(() {
                  index = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("SMS"),
              trailing: Text("10"),
              leading: Icon(Icons.sms),
              onTap: () {
                setState(() {
                  index = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Setting"),
              leading: Icon(Icons.settings),
              onTap: () {
                setState(() {
                  index = 2;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),

      body: _buildbody(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              label: "Home",
              activeIcon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sms,
                color: Colors.grey,
              ),
              label: "SMS",
              activeIcon: Icon(
                Icons.sms,
                color: Colors.orange,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              label: "Settings",
              activeIcon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ]),
    );
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 300,
                height: 200,
                child: Image.asset("asset/images/thien_nhien.jpg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text("Ho ten"),
            Text(
              "Trần Ngọc Hùng",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text("Ngay sinh: "),
            Row(
              children: [
                Expanded(
                    child: Text(
                        "${ngaySinh.day}/${ngaySinh.month}/${ngaySinh.year}")),
                IconButton(
                    onPressed: () async {
                      var selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2050),
                          currentDate: ngaySinh);
                      if (selectedDate != null) {
                        setState(() {
                          ngaySinh = selectedDate;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_month)),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text("Giới tính: "),
            RadioGroup(
                groupValue: gioiTinh,
                onChanged: (value) {
                  setState(() {
                    gioiTinh = value;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: "Nữ",
                        title: Text("Nữ"),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: "Nam",
                        title: Text("Nam"),
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(
              height: 15,
            ),
            Text("Sở thích: "),
            Text(
              "Thích xiền, nhìu nhà, xe, vàng",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Ngôn ngữ lập trình yêu thích của bạn: ",
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: nnlt,
              isExpanded: true,
              items: nnlts
                  .map(
                    (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  nnlt = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSMS() {
    return Center(
      child: Text(
        "SMS Screen",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSetting() {
    return Center(
      child: Text(
        "Settings Screen",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildbody() {
    switch (index) {
      case 0:
        return _buildHome();
      case 1:
        return _buildSMS();
      case 2:
        return _buildSetting();
      default:
        return _buildHome();
    }
  }
}