class MemberProfile {
  List<UserDatas> userData;

  MemberProfile({this.userData});

  MemberProfile.fromJson(Map<String, dynamic> json) {
    if (json['user_data'] != null) {
      userData = <UserDatas>[];
      json['user_data'].forEach((v) {
        userData.add(new UserDatas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user_data'] = this.userData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class UserDatas {
  String memberId;
  String memberName;
  String mobile;
  String email;
  String address;
  String city;
  String state;
  String country;
  String memberWebsite;
  String memberLinkedin;
  String memberInstagram;
  String memberFacebook;
  String imgName;
  String imgRName;
  String isActive;
  String createdAt;
  String companyName;
  String memberType;
  String lastYearTurnOver;
  String expectedTurnOver;
  String noOfEmployees;
  String yearOfEstablishment;
  String scale;
  String cin;
  String pan;
  String founderQual;
  String companyLogo;
  String cinFile;
  String cinFileRName;
  String aadhar;
  String aadharFile;
  String aadharFileRName;
  String gstnumber;
  String otherFile;
  String otherFileRName;
  String companyLogoRName;
  String companyAddress;
  String companyCity;
  String companyPhone;
  String companyEmail;
  String companyState;
  String companyCountry;
  String companyDescription;

  UserDatas(
      {this.memberId,
      this.memberName,
      this.mobile,
      this.email,
      this.address,
      this.city,
      this.state,
      this.country,
      this.memberWebsite,
      this.memberLinkedin,
      this.memberInstagram,
      this.memberFacebook,
      this.imgName,
      this.imgRName,
      this.isActive,
      this.createdAt,
      this.companyName,
      this.memberType,
      this.lastYearTurnOver,
      this.expectedTurnOver,
      this.noOfEmployees,
      this.yearOfEstablishment,
      this.scale,
      this.cin,
      this.pan,
      this.founderQual,
      this.companyLogo,
      this.cinFile,
      this.cinFileRName,
      this.aadhar,
      this.aadharFile,
      this.aadharFileRName,
      this.gstnumber,
      this.otherFile,
      this.otherFileRName,
      this.companyLogoRName,
      this.companyAddress,
      this.companyCity,
      this.companyPhone,
      this.companyEmail,
      this.companyState,
      this.companyCountry,
      this.companyDescription});

  UserDatas.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    memberName = json['member_name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    memberWebsite = json['member_website'];
    memberLinkedin = json['member_linkedin'];
    memberInstagram = json['member_instagram'];
    memberFacebook = json['member_facebook'];
    imgName = json['img_name'];
    imgRName = json['img_r_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    companyName = json['company_name'];
    memberType = json['member_type'];
    lastYearTurnOver = json['last_year_turn_over'];
    expectedTurnOver = json['expected_turn_over'];
    noOfEmployees = json['no_of_employees'];
    yearOfEstablishment = json['year_of_establishment'];
    scale = json['scale'];
    cin = json['cin'];
    pan = json['pan'];
    founderQual = json['founder_qual'];
    companyLogo = json['company_logo'];
    cinFile = json['cin_file'];
    cinFileRName = json['cin_file_r_name'];
    aadhar = json['aadhar'];
    aadharFile = json['aadhar_file'];
    aadharFileRName = json['aadhar_file_r_name'];
    gstnumber = json['gstnumber'];
    otherFile = json['other_file'];
    otherFileRName = json['other_file_r_name'];
    companyLogoRName = json['company_logo_r_name'];
    companyAddress = json['company_address'];
    companyCity = json['company_city'];
    companyPhone = json['company_phone'];
    companyEmail = json['company_email'];
    companyState = json['company_state'];
    companyCountry = json['company_country'];
    companyDescription = json['company_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_id'] = this.memberId;
    data['member_name'] = this.memberName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['member_website'] = this.memberWebsite;
    data['member_linkedin'] = this.memberLinkedin;
    data['member_instagram'] = this.memberInstagram;
    data['member_facebook'] = this.memberFacebook;
    data['img_name'] = this.imgName;
    data['img_r_name'] = this.imgRName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['company_name'] = this.companyName;
    data['member_type'] = this.memberType;
    data['last_year_turn_over'] = this.lastYearTurnOver;
    data['expected_turn_over'] = this.expectedTurnOver;
    data['no_of_employees'] = this.noOfEmployees;
    data['year_of_establishment'] = this.yearOfEstablishment;
    data['scale'] = this.scale;
    data['cin'] = this.cin;
    data['pan'] = this.pan;
    data['founder_qual'] = this.founderQual;
    data['company_logo'] = this.companyLogo;
    data['cin_file'] = this.cinFile;
    data['cin_file_r_name'] = this.cinFileRName;
    data['aadhar'] = this.aadhar;
    data['aadhar_file'] = this.aadharFile;
    data['aadhar_file_r_name'] = this.aadharFileRName;
    data['gstnumber'] = this.gstnumber;
    data['other_file'] = this.otherFile;
    data['other_file_r_name'] = this.otherFileRName;
    data['company_logo_r_name'] = this.companyLogoRName;
    data['company_address'] = this.companyAddress;
    data['company_city'] = this.companyCity;
    data['company_phone'] = this.companyPhone;
    data['company_email'] = this.companyEmail;
    data['company_state'] = this.companyState;
    data['company_country'] = this.companyCountry;
    data['company_description'] = this.companyDescription;
    return data;
  }
}
