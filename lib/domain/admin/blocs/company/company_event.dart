part of 'company_bloc.dart';

sealed class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

class AddCompaniesEvent extends CompanyEvent {
  final List<Company> companies;

  const AddCompaniesEvent(this.companies);

  @override
  List<Object> get props => [companies];
}

class AddCompanyStatusEvent extends CompanyEvent {
  final CompanyStateStatus companyStatus;
  const AddCompanyStatusEvent(this.companyStatus);

  @override
  List<Object> get props => [companyStatus];
}


class AddUserCompanyEvent extends CompanyEvent {
  final Company userCompany;

  const AddUserCompanyEvent(this.userCompany);

  @override
  List<Object> get props => [userCompany];
}

class AddSelectedCompanyFormEvent extends CompanyEvent {
  final int index;

  const AddSelectedCompanyFormEvent(this.index);

  @override
  List<Object> get props => [index];
}

class AddCompanyLogoStatusEvent extends CompanyEvent {
  final CompanyLogoStatus logoStatus;

  const AddCompanyLogoStatusEvent(this.logoStatus);

  @override
  List<Object> get props => [logoStatus];
}

class AddSelctedLogoPathEvent extends CompanyEvent {
  final String path;

  const AddSelctedLogoPathEvent(this.path);

  @override
  List<Object> get props => [path];
}
