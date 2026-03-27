import 'package:ngoc_hung66131218_flutter_app/rss/model/rss_resource.dart';

class RSSItem{
  String? title;
  String? pubDate;
  String? description;
  String? link;
  String? imageUrl;

  RSSItem.empty();

  RSSItem fromJson(Map<String, dynamic> json, {required RssResource r}){
    title = json['title'];
    pubDate = json['pubDate'];
    description = _getDescription(json['description'], r: r);
    link = json['link'];
    imageUrl = _getImageUrl(json['description'], r: r);
    return this;
  }

  String _getDescription (String rawDescription, {required RssResource r}){
    String startRegrex = r.startDescriptionRegrex;
    String endRegrex = r.endDescriptionRegrex;
    int start = rawDescription.indexOf(startRegrex) + startRegrex.length;
    if(start >= startRegrex.length){
      if(endRegrex.length > 0){
        int end = rawDescription.indexOf(endRegrex, start);
        return rawDescription.substring(start, end);
      }
      return rawDescription.substring(start);
    }
    return "";
  }


  String? _getImageUrl(String rawDescription, {required RssResource r}){
    String startimgRegrex = r.startImageRegrex;
    String endimgRegrex = r.endImageRegrex;
    int start = rawDescription.indexOf(startimgRegrex) + startimgRegrex.length;
    if(start >= startimgRegrex.length){
      if(endimgRegrex.length > 0){
        int end = rawDescription.indexOf(endimgRegrex, start);
        return rawDescription.substring(start, end);
      }
      return rawDescription.substring(start);
    }
    return "";
  }
}