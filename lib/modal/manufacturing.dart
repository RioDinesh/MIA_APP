class ManufacturingModel {
  List<ManufactureCategoryData> manufactureCategoryData;

  ManufacturingModel({this.manufactureCategoryData});

  ManufacturingModel.fromJson(Map<String, dynamic> json) {
    if (json['manufacture_category_data'] != null) {
      manufactureCategoryData = <ManufactureCategoryData>[];
      json['manufacture_category_data'].forEach((v) {
        manufactureCategoryData.add(new ManufactureCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.manufactureCategoryData != null) {
      data['manufacture_category_data'] =
          this.manufactureCategoryData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManufactureCategoryData {
  String manCatId;
  String manCatName;
  String manCatImage;

  ManufactureCategoryData({this.manCatId, this.manCatName, this.manCatImage});

  ManufactureCategoryData.fromJson(Map<String, dynamic> json) {
    manCatId = json['man_cat_id'];
    manCatName = json['man_cat_name'];
    manCatImage = json['man_cat_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['man_cat_id'] = this.manCatId;
    data['man_cat_name'] = this.manCatName;
    data['man_cat_image'] = this.manCatImage;
    return data;
  }
}