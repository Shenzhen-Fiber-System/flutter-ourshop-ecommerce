part of 'company_bloc.dart';


enum CompanyStateStatus { initial, loading, loaded, error }

enum CompanyLogoStatus { initial, loading, loaded, error }

class CompanyState extends Equatable {
  final List<Company> companies;
  final CompanyStateStatus status;
  final Company userCompany;
  final int selectedMyCompanyFormIndex;
  final CompanyLogoStatus logoStatus;
  final String selectedLogoPath;
  const CompanyState({
    this.companies = const [],
    this.status = CompanyStateStatus.initial,
    this.userCompany = const Company(
      id: '',
      name: '',
      address: '',
      phoneNumber: '',
      countryId: '',
      mainCategoryId: '',
      currentBusinessCategoryId: '',
      folderName: '',
      totalEmployee: 0,
      websiteUrl: '',
      legalOwner: '',
      officeSize: 0,
      advantages: '',
      subdomain: '',
      email: '',
    ),
    this.selectedMyCompanyFormIndex = 0,
    this.logoStatus = CompanyLogoStatus.initial,
    this.selectedLogoPath = '',
  });

  CompanyState copyWith({
    List<Company>? companies,
    CompanyStateStatus? status,
    Company? userCompany,
    int? selectedMyCompanyFormIndex,
    CompanyLogoStatus? logoStatus,
    String? selectedLogoPath,
  }) {
    return CompanyState(
      companies: companies ?? this.companies,
      status: status ?? this.status,
      userCompany: userCompany ?? this.userCompany,
      selectedMyCompanyFormIndex: selectedMyCompanyFormIndex ?? this.selectedMyCompanyFormIndex,
      logoStatus: logoStatus ?? this.logoStatus,
      selectedLogoPath: selectedLogoPath ?? this.selectedLogoPath,
    );
  }
  
  @override
  List<Object> get props => [
    companies, 
    status,
    userCompany,
    selectedMyCompanyFormIndex,
    logoStatus,
    selectedLogoPath,
  ];
}
