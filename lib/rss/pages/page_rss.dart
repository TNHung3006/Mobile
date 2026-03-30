import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngoc_hung66131218_flutter_app/rss/controller/rss_controller_simple.dart';
import 'package:ngoc_hung66131218_flutter_app/rss/model/rss_item.dart';
import 'package:ngoc_hung66131218_flutter_app/rss/pages/page_view_rss.dart';

class PageRss extends StatelessWidget {
  PageRss({super.key});
  final SimpleControllerRss controller = Get.put(SimpleControllerRss());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<SimpleControllerRss>(
            id: "title",
            builder: (controller) {
              return Text(controller.currentResourceName);
            }
        ),backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          GetBuilder<SimpleControllerRss>(
              init: controller,
              id: "header",
              builder: (controller) {
                List<String> headers = controller.headerRecources;
                return DropdownButton<String>(
                  value: controller.resourceHeader,
                  items: headers.map(
                    (e) {
                      return DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    controller.changedResourceHeader(value!);
                  },
                );
              },
          )
        ],
      ),
      drawer: Drawer(
        child: GetBuilder<SimpleControllerRss>(
          id: "resource",
          init: controller,
          builder: (controller) => Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Ngoc Hung"),
                accountEmail: Text("ngochung@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("asset/images/thien_nhien.jpg"),
                ),
              ),
              Text("Chon nguon bao"),
              RadioGroup(
                groupValue: controller.currentResourceName,
                onChanged: (value) {
                    controller.changeResource(value!);
                },
                child: Column(
                  children: controller.resources.map(
                    (e) {
                      return RadioListTile<String>(
                        value: e.name,
                        title: Text(e.name),
                      );
                    },
                  ).toList(),
                )
              )
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.readRss(),
        child: GetBuilder<SimpleControllerRss>(
          id: "rssList",
          init: controller,
          builder: (controller){
            var rssItems = controller.rssList;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    RSSItem item = rssItems[index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(item.imageUrl?? "No Url")
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder:(context) => PageViewRss(
                                        link: item.link?? "No Url",
                                        resourceName: controller.currentResourceName,
                                      ),
                                    ),
                                  );
                                },
                                  child: Text(item.title?? " ", style: TextStyle(color: Colors.blue),))
                            ),
                          ],
                        ),
                        Text(item.description?? "")
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: rssItems.length
              ),
            );
          }
        ),
      ),
    );
  }
}
