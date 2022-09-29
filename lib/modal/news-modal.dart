class News {
  List<NewsData> newsData;

  News({this.newsData});

  News.fromJson(Map<String, dynamic> json) {
    if (json['news_data'] != null) {
      newsData = new List<NewsData>();
      json['news_data'].forEach((v) {
        newsData.add(new NewsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newsData != null) {
      data['news_data'] = this.newsData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsData {
  String newsId;
  String newsTitle;
  String description;
  String newsImage;
  String newsImageRName;
  String newsAuthor;
  String isActive;
  String createdAt;
  String modifiedAt;

  NewsData(
      {this.newsId,
      this.newsTitle,
      this.description,
      this.newsImage,
      this.newsImageRName,
      this.newsAuthor,
      this.isActive,
      this.createdAt,
      this.modifiedAt});

  NewsData.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    newsTitle = json['news_title'];
    description = json['description'];
    newsImage = json['news_image'];
    newsImageRName = json['news_image_r_name'];
    newsAuthor = json['news_author'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['news_title'] = this.newsTitle;
    data['description'] = this.description;
    data['news_image'] = this.newsImage;
    data['news_image_r_name'] = this.newsImageRName;
    data['news_author'] = this.newsAuthor;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    return data;
  }
}