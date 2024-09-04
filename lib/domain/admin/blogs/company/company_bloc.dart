import '../../../../ui/pages/pages.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  // ignore: prefer_final_fields
  CompanyService _companyService;
  CompanyBloc(CompanyService companyService) : _companyService = companyService,
  super(const CompanyState()) {
    on<AddCompaniesEvent>((event, emit) => emit(state.copyWith(companies: event.companies)));
  }

  Future<void> getCompanies() async {
    final dynamic companies = await _companyService.getCompanies();
    add(AddCompaniesEvent(companies));
  }
}
