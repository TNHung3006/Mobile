import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ngoc_hung66131218_flutter_app/rss/model/rss_item.dart';
import 'package:ngoc_hung66131218_flutter_app/rss/model/rss_resource.dart';
import 'package:xml2json/xml2json.dart';

class SimpleControllerRss extends GetxController{
  List<RssResource> resources = rssResources;
  RssResource currentResource = rssResources[0];
  String? _rssUrl;
  String? _resourceHeader;
  var _rssList = <RSSItem>[];

  List<RSSItem> get rssList => _rssList;
  String get currentResourceName => currentResource.name;
  String? get resourceHeader => _resourceHeader;
  List<String> get headerRecources => currentResource.resourceHeaders.keys.toList();

  @override
  void onInit() {
    super.onInit();
    if(_rssUrl==null) _rssUrl = currentResource.resourceHeaders.values.toList()[0];
    if(_resourceHeader==null) _resourceHeader = currentResource.resourceHeaders.keys.toList()[0];
  }


  @override
  void onReady() {
    super.onReady();
    readRss();
  }

  void changeResource(String resourceName){
    if(resourceName != currentResource.name){
      //1 thiet lap currentResource
      for(var r in resources){
        if(r.name == resourceName){
          currentResource = r;
          break; // Tìm thấy nguồn báo tương ứng thì thoát khỏi vòng lặp
        }
      }
      //2 thiet lap _resourceheader
      _resourceHeader = currentResource.resourceHeaders.keys.toList()[0];
      //3. thiet lap _rssUrl
      _rssUrl = currentResource.resourceHeaders.values.toList()[0];
      //4. update: cac Getbuilder:, resources, resourceName, headers
      update(["resource", "header"]);
      //5. doc Rss
      readRss();
    }
  }

  void changedResourceHeader(String header){
    if(header != _resourceHeader){
      //1. thiet lap _resourceHeader
        _resourceHeader = header;
      //2. thiet lap _rssUrl
        _rssUrl = currentResource.resourceHeaders[header];
      //3. update: header
      update(["header"]);
      //4. Goi readRss
      readRss();

    }
  }

  Future<void> readRss() async{
    _fetchRSS(_rssUrl!).then(
      (value) {
        _rssList = value?.map(
            (e) => RSSItem.empty().fromJson(e, r: currentResource),
        ).toList()?? [];
        update(["rssList"]);
      },
    ).onError(
        (error, stackTrace){
          print("Loi doc Rss $error");
        }
    );
  }

  Future<List<dynamic>?> _fetchRSS(String rssUrl) async{
    final response = await http.get(Uri.parse(rssUrl));
    if(response.statusCode == 200){
      final xml2Json = Xml2Json();
      xml2Json.parse(utf8.decode(response.bodyBytes));
      String rssJson = xml2Json.toParker();
      //print(rssJson);
      Map<String, dynamic> jsonData = jsonDecode(rssJson);
      return jsonData["rss"]["channel"]["item"];
    }
  }
}