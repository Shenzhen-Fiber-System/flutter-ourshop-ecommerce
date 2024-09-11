


import '../../ui/pages/pages.dart';

class CompanyResponse extends Equatable {
    final bool success;
    final String message;
    final dynamic data;

    const CompanyResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    factory CompanyResponse.fromJson(Map<String, dynamic> json) => CompanyResponse(
        success: json["success"],
        message: json["message"],
        data: json['data'] is List ? List<Company>.from(json["data"].map((x) => Company.fromJson(x))) : Company.fromJson(json['data']),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
    
      @override
      List<Object?> get props => [
        success,
        message,
        data,
      ];
}

class Company extends Equatable {
    final String id;
    final String? name;
    final String? address;
    final String? phoneNumber;
    final String? countryId;
    final String? mainCategoryId;
    final String? currentBusinessCategoryId;
    final String? folderName;
    final int? totalEmployee;
    final String? websiteUrl;
    final String? legalOwner;
    final int? officeSize;
    final String? advantages;
    final String? subdomain;
    final String? email;
    final int? qtyProductLandingPage;

    const Company({
        required this.id,
        this.name,
        this.address,
        this.phoneNumber,
        this.countryId,
        this.mainCategoryId,
        this.currentBusinessCategoryId,
        this.folderName,
        this.totalEmployee,
        this.websiteUrl,
        this.legalOwner,
        this.officeSize,
        this.advantages,
        this.subdomain,
        this.email,
        this.qtyProductLandingPage,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        countryId: json["countryId"],
        mainCategoryId: json["mainCategoryId"],
        currentBusinessCategoryId: json["currentBusinessCategoryId"],
        folderName: json["folderName"],
        totalEmployee: json["totalEmployee"],
        websiteUrl: json["websiteUrl"],
        legalOwner: json["legalOwner"],
        officeSize: json["officeSize"],
        advantages: json["advantages"],
        subdomain: json["subdomain"],
        email: json["email"],
        qtyProductLandingPage: json["qtyProductLandingPage"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phoneNumber": phoneNumber,
        "countryId": countryId,
        "mainCategoryId": mainCategoryId,
        "currentBusinessCategoryId": currentBusinessCategoryId,
        "folderName": folderName,
        "totalEmployee": totalEmployee,
        "websiteUrl": websiteUrl,
        "legalOwner": legalOwner,
        "officeSize": officeSize,
        "advantages": advantages,
        "subdomain": subdomain,
        "email": email,
        "qtyProductLandingPage": qtyProductLandingPage,
    };
    
      @override
      List<Object?> get props => [
        id, 
        name, 
        address, 
        phoneNumber, 
        countryId, 
        mainCategoryId, 
        currentBusinessCategoryId, 
        folderName, 
        totalEmployee, 
        websiteUrl, 
        legalOwner, 
        officeSize, 
        advantages, 
        subdomain,
        email,
        qtyProductLandingPage
      ];
}