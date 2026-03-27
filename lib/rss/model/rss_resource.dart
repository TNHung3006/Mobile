class RssResource {
  String id, name;
  String startDescriptionRegrex, endDescriptionRegrex;
  String startImageRegrex, endImageRegrex;
  Map<String, String> resourceHeaders;
  RssResource({
    required this.id,
    required this.name,
    required this.startDescriptionRegrex,
    required this.endDescriptionRegrex,
    required this.startImageRegrex,
    required this.endImageRegrex,
    required this.resourceHeaders,
  });
}

List<RssResource> rssResources = [
  RssResource(
      id: "vnexpress",
      name: "VN Express",
      startDescriptionRegrex: "</a></br>",
      endDescriptionRegrex: "",
      startImageRegrex: '<img src="',
      endImageRegrex: '"',
      resourceHeaders: {
        "Trang chủ":"https://vnexpress.net/rss/tin-moi-nhat.rss",
        "Tin mới nhất": "https://vnexpress.net/rss/tin-moi-nhat.rss",
        "Thế giới": "https://vnexpress.net/rss/the-gioi.rss",
        "Giáo dục": "https://vnexpress.net/rss/giao-duc.rss",
        "Giải trí": "https://vnexpress.net/rss/giai-tri.rss",
        "Thể thao": "https://vnexpress.net/rss/the-thao.rss",
        "Tâm sự": "https://vnexpress.net/rss/tam-su.rss",
        "Số hoá": "https://vnexpress.net/rss/so-hoa.rss",
        "Xe": "https://vnexpress.net/rss/oto-xe-may.rss",
      }
  ),
  RssResource(
      id: "tuoitre",
      name: "Tuổi Trẻ",
      startDescriptionRegrex: "</a>",
      endDescriptionRegrex: "",
      startImageRegrex: '<img src="',
      endImageRegrex: '"',
      resourceHeaders: {
        "Trang chủ": "https://tuoitre.vn/rss/tin-moi-nhat.rss",
        "Thế giới": "https://tuoitre.vn/rss/the-gioi.rss",
        "Kinh doanh": "https://tuoitre.vn/rss/kinh-doanh.rss",
        "Giải trí": "https://tuoitre.vn/rss/giai-tri.rss",
        "Thể thao": "https://tuoitre.vn/rss/the-thao.rss",
      }
  ),
  RssResource(
      id: "thanhnien",
      name: "Thanh Niên",
      startDescriptionRegrex: "</a>",
      endDescriptionRegrex: "",
      startImageRegrex: '<img src="',
      endImageRegrex: '"',
      resourceHeaders: {
        "Trang chủ": "https://thanhnien.vn/rss/home.rss",
        "Thời sự": "https://thanhnien.vn/rss/thoi-su.rss",
        "Thế giới": "https://thanhnien.vn/rss/the-gioi.rss",
        "Kinh tế": "https://thanhnien.vn/rss/kinh-te.rss",
        "Giới trẻ": "https://thanhnien.vn/rss/gioi-tre.rss",
      }
  ),
];