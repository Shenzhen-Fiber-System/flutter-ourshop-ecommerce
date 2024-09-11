
import 'dart:developer';

import '../../../../ui/pages/pages.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyService _companyService;
  CompanyBloc(CompanyService companyService) : _companyService = companyService,
  super(const CompanyState()) {
    on<AddCompaniesEvent>((event, emit) => emit(state.copyWith(companies: event.companies)));
    on<AddCompanyStatusEvent>((event, emit) => emit(state.copyWith(status: event.companyStatus)));
    on<AddUserCompanyEvent>((event, emit) => emit(state.copyWith(userCompany: event.userCompany)));
    on<AddSelectedCompanyFormEvent>((event, emit) => emit(state.copyWith(selectedMyCompanyFormIndex: event.index)));
    on<AddCompanyLogoStatusEvent>((event, emit) => emit(state.copyWith(logoStatus: event.logoStatus)));
    on<AddSelctedLogoPathEvent>((event, emit) => emit(state.copyWith(selectedLogoPath: event.path)));
  }

  Future<void> getCompanies() async {
    final dynamic companies = await _companyService.getCompanies();
    if (companies is List<Company>) {
      add(AddCompaniesEvent(companies));
    }
  }

  Future<void> getCompanyById(String id) async {
    add(const AddCompanyStatusEvent(CompanyStateStatus.loading));
    final dynamic company = await _companyService.getCompanyById(id);
    if (company is Company) {
      add(AddUserCompanyEvent(company));
    }
    add(const AddCompanyStatusEvent(CompanyStateStatus.loaded));
  }


  Future<void> chooseCompanyLogo() async {
    try {
      add(const AddCompanyLogoStatusEvent(CompanyLogoStatus.loading));
      final ImagePicker picker = locator<ImagePicker>();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        add(AddSelctedLogoPathEvent(image.path));
        await _companyService.uploadCompnayLogo(File(image.path));
      }
      add(const AddCompanyLogoStatusEvent(CompanyLogoStatus.loaded));
    } catch (e) {
      log('Something went wrong while choosing company logo :$e');
      add(const AddCompanyLogoStatusEvent(CompanyLogoStatus.error));
    }
  }

  void addSelectedCompanyForm(int index) =>  add(AddSelectedCompanyFormEvent(index));
}
