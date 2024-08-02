


import '../../ui/pages/pages.dart';

class CompanyResponse extends Equatable {
    final bool success;
    final String message;
    final List<Company> data;

    const CompanyResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    factory CompanyResponse.fromJson(Map<String, dynamic> json) => CompanyResponse(
        success: json["success"],
        message: json["message"],
        data: List<Company>.from(json["data"].map((x) => Company.fromJson(x))),
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

    const Company({
        required this.id,
        required this.name,
        required this.address,
        required this.phoneNumber,
        required this.countryId,
        required this.mainCategoryId,
        required this.currentBusinessCategoryId,
        required this.folderName,
        required this.totalEmployee,
        required this.websiteUrl,
        required this.legalOwner,
        required this.officeSize,
        required this.advantages,
        required this.subdomain,
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
        subdomain
      ];
}