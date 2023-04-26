import '../data/database_helper.dart';

class AppealModel {
  int? id;
  String? phone;
  String? district;
  String? request;
  String? description;
  int? allowed;

  AppealModel(this.phone, this.district, this.request, this.description, this.allowed);
  AppealModel.withId(this.id,this.phone, this.district, this.request, this.description, this.allowed);


  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "phone": phone,
      "district": district,
      "request": request,
      "description": description,
      "allowed": allowed,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  AppealModel.fromMap(Map<String, Object?> map) {
    id = (map["id"] as int?)!;
    phone = (map["phone"] as String?)!;
    district = (map["district"] as String?)!;
    request = (map["request"] as String?)!;
    description = (map["description"] as String?)!;
    allowed = (map["allowed"] as int?)!;
  }

  AppealModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    phone = json['phone'];
    district = json['district'];
    request = json['request'];
    description = json['description'];
    allowed = json['allowed'];
  }
}
