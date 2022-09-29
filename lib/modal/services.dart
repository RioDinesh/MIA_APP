class ServicesModel {
  List<ServiceCatData> serviceCatData;

  ServicesModel({this.serviceCatData});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    if (json['service_cat_data'] != null) {
      serviceCatData = <ServiceCatData>[];
      json['service_cat_data'].forEach((v) {
        serviceCatData.add(new ServiceCatData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceCatData != null) {
      data['service_cat_data'] =
          this.serviceCatData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceCatData {
  String serCatId;
  String serCatName;
  String serCatImage;

  ServiceCatData({this.serCatId, this.serCatName, this.serCatImage});

  ServiceCatData.fromJson(Map<String, dynamic> json) {
    serCatId = json['ser_cat_id'];
    serCatName = json['ser_cat_name'];
    serCatImage = json['ser_cat_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser_cat_id'] = this.serCatId;
    data['ser_cat_name'] = this.serCatName;
    data['ser_cat_image'] = this.serCatImage;
    return data;
  }
}