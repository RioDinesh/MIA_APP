class Bussiness {
  List<BusinessData> businessData;

  Bussiness({this.businessData});

  Bussiness.fromJson(Map<String, dynamic> json) {
    if (json['business_data'] != null) {
      businessData = <BusinessData>[];
      json['business_data'].forEach((v) {
        businessData.add(new BusinessData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessData != null) {
      data['business_data'] = this.businessData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessData {
  String memberCompanyId;
  String memberId;
  String companyName;
  String companyLogo;
  String yearOfEstablishment;
  String gstnumber;
  String companyAddress;
  String companyCity;
  String companyPhone;
  String companyEmail;
  String companyState;
  String companyCountry;
  String companyDescription;
  String isActive;
  String createdAt;

  BusinessData(
      {this.memberCompanyId,
      this.memberId,
      this.companyName,
      this.companyLogo,
      this.yearOfEstablishment,
      this.gstnumber,
      this.companyAddress,
      this.companyCity,
      this.companyPhone,
      this.companyEmail,
      this.companyState,
      this.companyCountry,
      this.companyDescription,
      this.isActive,
      this.createdAt});

  BusinessData.fromJson(Map<String, dynamic> json) {
    memberCompanyId = json['member_company_id'];
    memberId = json['member_id'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    yearOfEstablishment = json['year_of_establishment'];
    gstnumber = json['gstnumber'];
    companyAddress = json['company_address'];
    companyCity = json['company_city'];
    companyPhone = json['company_phone'];
    companyEmail = json['company_email'];
    companyState = json['company_state'];
    companyCountry = json['company_country'];
    companyDescription = json['company_description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_company_id'] = this.memberCompanyId;
    data['member_id'] = this.memberId;
    data['company_name'] = this.companyName;
    data['company_logo'] = this.companyLogo;
    data['year_of_establishment'] = this.yearOfEstablishment;
    data['gstnumber'] = this.gstnumber;
    data['company_address'] = this.companyAddress;
    data['company_city'] = this.companyCity;
    data['company_phone'] = this.companyPhone;
    data['company_email'] = this.companyEmail;
    data['company_state'] = this.companyState;
    data['company_country'] = this.companyCountry;
    data['company_description'] = this.companyDescription;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    return data;
  }
}