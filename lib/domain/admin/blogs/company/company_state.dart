part of 'company_bloc.dart';

class CompanyState extends Equatable {
  final List<Company> companies;
  const CompanyState({
    this.companies = const [],
  });

  CompanyState copyWith({
    List<Company>? companies,
  }) {
    return CompanyState(
      companies: companies ?? this.companies,
    );
  }
  
  @override
  List<Object> get props => [companies];
}
