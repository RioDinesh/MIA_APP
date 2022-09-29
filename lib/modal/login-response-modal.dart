class LoginResponse {
  bool status;
  UserData userData;
  String message;

  LoginResponse({this.status, this.userData, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userData != null) {
      data['user_data'] = this.userData.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class UserData {
  String memberId;
  String memberName;
  String mobile;
  String email;
  String password;
  String isActive;
  String createdAt;
  String modifiedAt;

  UserData(
      {this.memberId,
      this.memberName,
      this.mobile,
      this.email,
      this.password,
      this.isActive,
      this.createdAt,
      this.modifiedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    memberName = json['member_name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_id'] = this.memberId;
    data['member_name'] = this.memberName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    return data;
  }
}