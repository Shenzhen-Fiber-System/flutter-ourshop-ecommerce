import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class UserResponse extends Equatable {
    final bool success;
    final String message;
    final User data;

    const UserResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"],
        message: json["message"],
        data: User.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
      @override
      List<Object?> get props => [success, message, data];
}

class User extends Equatable {
    final String id;
    final String username;
    final String name;
    final String lastName;
    final String email;
    final dynamic address;
    final String phoneNumberCode;
    final String phoneNumber;
    final int accessFailedCount;
    final dynamic birthdate;
    final dynamic title;
    final dynamic countryId;

    const User({
        required this.id,
        required this.username,
        required this.name,
        required this.lastName,
        required this.email,
        required this.address,
        required this.phoneNumberCode,
        required this.phoneNumber,
        required this.accessFailedCount,
        required this.birthdate,
        required this.title,
        required this.countryId,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        address: json["address"],
        phoneNumberCode: json["phoneNumberCode"],
        phoneNumber: json["phoneNumber"],
        accessFailedCount: json["accessFailedCount"],
        birthdate: json["birthdate"],
        title: json["title"],
        countryId: json["countryId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "lastName": lastName,
        "email": email,
        "address": address,
        "phoneNumberCode": phoneNumberCode,
        "phoneNumber": phoneNumber,
        "accessFailedCount": accessFailedCount,
        "birthdate": birthdate,
        "title": title,
        "countryId": countryId,
    };
    
    @override
    
    List<Object?> get props => [
      id, 
      username, 
      name, 
      lastName, 
      email, 
      address, 
      phoneNumberCode, 
      phoneNumber, 
      accessFailedCount, 
      birthdate, 
      title, 
      countryId
    ];
}

class Auth{
  final String username;
  final String password;

  Auth({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> login() => {
    "username": username,
    "password": password,
  };
}


class NewUser extends Equatable {
  
  final String username;
  final String name;
  final String lastName;
  final String password;
  final String email;
  final String phoneNumberCode;
  final String phoneNumber;
  final String? companyName;
  final String? countryId;
  final List<String> rolesIds;
  final String language;

  const NewUser({
    required this.username,
    required this.name,
    required this.lastName,
    required this.password,
    required this.email,
    required this.phoneNumberCode,
    required this.phoneNumber,
    this.companyName,
    this.countryId,
    required this.rolesIds,
    required this.language,
  });

  Map<String, dynamic> newUserToJson() => {
    "user": {
        "username":username,
        "email":email,
        "password":password,
        "name":name,
        "lastName":lastName,
        "phoneNumberCode":phoneNumberCode,
        "phoneNumber":phoneNumber,
        "countryId":countryId,
    },
    "company": {
        "name": companyName,
        "countryId": countryId
    },
    "roleIds": rolesIds,
    "language": language,
  };
  
  @override
  List<Object?> get props => [
    username,
    name,
    lastName,
    password,
    email,
    phoneNumberCode,
    phoneNumber,
    companyName,
    countryId,
    rolesIds,
    language
  ];
}
