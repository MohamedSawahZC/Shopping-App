class LoginModel{
  bool?status;
  String?message;
  userModel?data;
  LoginModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null? userModel.fromJson(json['data']):null;
  }
}

class userModel{
  int? id;
  String?name;
  String?email;
  String?phone;
  String?image;
  int?points;
  int?credit;
  String?token;
  userModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }
}