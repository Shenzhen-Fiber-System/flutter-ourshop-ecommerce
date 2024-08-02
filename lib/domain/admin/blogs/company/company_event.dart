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
