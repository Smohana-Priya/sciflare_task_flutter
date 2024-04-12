class UserDataModal {
  String? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;

  UserDataModal({this.id, this.name, this.email, this.mobile, this.gender});

  UserDataModal.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['emil'] = email;
    data['mobile'] = mobile;
    data['gender'] = gender;
    return data;
  }
}
