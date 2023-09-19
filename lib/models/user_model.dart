// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  late String username;
  late String useremail;
  late String userpass;
  late String userimage;
  late String userbirthday;
  late String usergendre;
  late String userphone;
  late String userId;

  UserModel( 
      {required this.username,
      required this.userId,
      required this.useremail,
      required this.userpass,
      required this.userimage,
      required this.userbirthday,
      required this.userphone,
      required this.usergendre});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'useremail': useremail,
      'userpass': userpass,
      'userimage': userimage,
      'userbirthday': userbirthday,
      'usergendre': usergendre,
      'userphone':userphone,
      'userId':userId
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId:map['userId'] ,
      username: map['username'],
      useremail: map['useremail'],
      userpass: map['userpass'],
      userimage: map['userimage'],
      userbirthday: map['userbirthday'],
      usergendre: map['usergendre'],
      userphone: map['userphone']
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

 


  UserModel copyWith({
     String? username,
     String? useremail,
     String? userpass,
     String? userimage,
     String? userbirthday,
     String? usergendre,
     String? userphone,
     String? userId
  }) {
    return UserModel(
      userId: userId??this.userId,
       username: username ?? this.username,
      useremail: useremail??this.useremail,
      userpass: userpass??this.userpass,
      userimage: username?? this.userimage,
      userbirthday: userbirthday??this.userbirthday,
      usergendre: usergendre??this.usergendre,
      userphone: userphone??this.userphone

    );
  }
}
