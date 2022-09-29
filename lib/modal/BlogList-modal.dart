class BlogList {
  List<BlogData> blogData;

  BlogList({this.blogData});

  BlogList.fromJson(Map<String, dynamic> json) {
    if (json['blog_data'] != null) {
      blogData = <BlogData>[];
      json['blog_data'].forEach((v) {
        blogData.add(new BlogData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blogData != null) {
      data['blog_data'] = this.blogData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlogData {
  String blogId;
  String blogTitle;
  String description;
  String blogImage;
  String blogImageRName;
  String blogAuthor;
  String isActive;
  
  String createdAt;
  String modifiedAt;

  BlogData(
      {this.blogId,
      this.blogTitle,
      this.description,
      this.blogImage,
      this.blogImageRName,
      this.blogAuthor,
      
      this.isActive,
      this.createdAt,
      this.modifiedAt});

  BlogData.fromJson(Map<String, dynamic> json) {
    blogId = json['blog_id'];
    blogTitle = json['blog_title'];
    description = json['description'];
    blogImage = json['blog_image'];
    blogImageRName = json['blog_image_r_name'];
    blogAuthor = json['blog_author'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blog_id'] = this.blogId;
    data['blog_title'] = this.blogTitle;
    data['description'] = this.description;
    data['blog_image'] = this.blogImage;
    data['blog_image_r_name'] = this.blogImageRName;
    data['blog_author'] = this.blogAuthor;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    return data;
  }
}