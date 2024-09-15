import '../../ui/pages/pages.dart';

class CompanyResponse<T> extends Equatable {
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
    final String name;
    final String? address;
    final String? phoneNumber;
    final String? phoneNumberCode;
    final String? countryId;
    final Country? country;
    final String? mainCategoryId;
    final dynamic currentBusinessCategoryId;
    final dynamic folderName;
    final int totalEmployee;
    final String websiteUrl;
    final String legalOwner;
    final int officeSize;
    final String advantages;
    final String subdomain;
    final String email;
    final dynamic qtyProductLandingPage;
    final List<dynamic> socialMedias;
    final List<Bank> banks;
    final dynamic whatsappNumber;
    final bool hasProfileImg;

    const Company({
        required this.id,
        required this.name,
        required this.address,
        required this.phoneNumber,
        required this.phoneNumberCode,
        required this.countryId,
        required this.country,
        required this.mainCategoryId,
        required this.currentBusinessCategoryId,
        required this.folderName,
        required this.totalEmployee,
        required this.websiteUrl,
        required this.legalOwner,
        required this.officeSize,
        required this.advantages,
        required this.subdomain,
        required this.email,
        required this.qtyProductLandingPage,
        required this.socialMedias,
        required this.banks,
        required this.whatsappNumber,
        required this.hasProfileImg,
    });

    Company copyWith({
        String? id,
        String? name,
        String? address,
        String? phoneNumber,
        String? phoneNumberCode,
        String? countryId,
        Country? country,
        String? mainCategoryId,
        dynamic currentBusinessCategoryId,
        dynamic folderName,
        int? totalEmployee,
        String? websiteUrl,
        String? legalOwner,
        int? officeSize,
        String? advantages,
        String? subdomain,
        String? email,
        dynamic qtyProductLandingPage,
        List<dynamic>? socialMedias,
        List<Bank>? banks,
        dynamic whatsappNumber,
        bool? hasProfileImg,
    }) => 
        Company(
            id: id ?? this.id,
            name: name ?? this.name,
            address: address ?? this.address,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            phoneNumberCode: phoneNumberCode ?? this.phoneNumberCode,
            countryId: countryId ?? this.countryId,
            country: country ?? this.country,
            mainCategoryId: mainCategoryId ?? this.mainCategoryId,
            currentBusinessCategoryId: currentBusinessCategoryId ?? this.currentBusinessCategoryId,
            folderName: folderName ?? this.folderName,
            totalEmployee: totalEmployee ?? this.totalEmployee,
            websiteUrl: websiteUrl ?? this.websiteUrl,
            legalOwner: legalOwner ?? this.legalOwner,
            officeSize: officeSize ?? this.officeSize,
            advantages: advantages ?? this.advantages,
            subdomain: subdomain ?? this.subdomain,
            email: email ?? this.email,
            qtyProductLandingPage: qtyProductLandingPage ?? this.qtyProductLandingPage,
            socialMedias: socialMedias ?? this.socialMedias,
            banks: banks ?? this.banks,
            whatsappNumber: whatsappNumber ?? this.whatsappNumber,
            hasProfileImg: hasProfileImg ?? this.hasProfileImg,
        );

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        phoneNumberCode: json["phoneNumberCode"],
        countryId: json["countryId"],
        country: Country.fromJson(json["country"]),
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
        socialMedias: List<dynamic>.from(json["socialMedias"].map((x) => x)),
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
        whatsappNumber: json["whatsappNumber"],
        hasProfileImg: json["hasProfileImg"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phoneNumber": phoneNumber,
        "phoneNumberCode": phoneNumberCode,
        "countryId": countryId,
        "country": country?.toJson(),
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
        "socialMedias": List<dynamic>.from(socialMedias.map((x) => x)),
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
        "whatsappNumber": whatsappNumber,
        "hasProfileImg": hasProfileImg,
    };
    
    @override
    
    List<Object?> get props => [
        id,
        name,
        address,
        phoneNumber,
        phoneNumberCode,
        countryId,
        country,
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
        qtyProductLandingPage,
        socialMedias,
        banks,
        whatsappNumber,
        hasProfileImg,
    ];
}

class Bank extends Equatable {
    final String id;
    final String companyId;
    final String bankId;
    final String accountType;
    final String accountNumber;
    final String swiftCode;
    final String address;
    final String phoneNumber;
    final String intermediaryBankId;
    // final bool showOrder;
    final String bankCountryId;
    final String intermediaryBankCountryId;

    const Bank({
        required this.id,
        required this.companyId,
        required this.bankId,
        required this.accountType,
        required this.accountNumber,
        required this.swiftCode,
        required this.address,
        required this.phoneNumber,
        required this.intermediaryBankId,
        // required this.showOrder,
        required this.bankCountryId,
        required this.intermediaryBankCountryId,
    });

    Bank copyWith({
        String? id,
        String? companyId,
        String? bankId,
        String? accountType,
        String? accountNumber,
        String? swiftCode,
        String? address,
        String? phoneNumber,
        String? intermediaryBankId,
        // bool? showOrder,
        String? bankCountryId,
        String? intermediaryBankCountryId,
    }) => 
        Bank(
            id: id ?? this.id,
            companyId: companyId ?? this.companyId,
            bankId: bankId ?? this.bankId,
            accountType: accountType ?? this.accountType,
            accountNumber: accountNumber ?? this.accountNumber,
            swiftCode: swiftCode ?? this.swiftCode,
            address: address ?? this.address,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            intermediaryBankId: intermediaryBankId ?? this.intermediaryBankId,
            // showOrder: showOrder ?? this.showOrder,
            bankCountryId: bankCountryId ?? this.bankCountryId,
            intermediaryBankCountryId: intermediaryBankCountryId ?? this.intermediaryBankCountryId,
        );

    factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        companyId: json["companyId"],
        bankId: json["bankId"],
        accountType: json["accountType"],
        accountNumber: json["accountNumber"],
        swiftCode: json["swiftCode"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        intermediaryBankId: json["intermediaryBankId"],
        // showOrder: json["showOrder"],
        bankCountryId: json["bankCountryId"],
        intermediaryBankCountryId: json["intermediaryBankCountryId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "bankId": bankId,
        "accountType": accountType,
        "accountNumber": accountNumber,
        "swiftCode": swiftCode,
        "address": address,
        "phoneNumber": phoneNumber,
        "intermediaryBankId": intermediaryBankId,
        // "showOrder": showOrder,
        "bankCountryId": bankCountryId,
        "intermediaryBankCountryId": intermediaryBankCountryId,
    };

    @override
    
    List<Object?> get props => [
        id,
        companyId,
        bankId,
        accountType,
        accountNumber,
        swiftCode,
        address,
        phoneNumber,
        intermediaryBankId,
        // showOrder,
        bankCountryId,
        intermediaryBankCountryId,
    ];
}


