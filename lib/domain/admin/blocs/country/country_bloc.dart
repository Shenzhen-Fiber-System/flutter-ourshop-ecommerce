import '../../../../ui/pages/pages.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {

  final CountryService _countryService;
  
  CountryBloc(CountryService countryService) : _countryService = countryService, 
  super(const CountryState()) {
    on<AddCountriesEvent>((event, emit) => emit(state.copyWith(countries: event.countries)));
  }


  Future<void> fetchCountries() async {
    final countries = await _countryService.getCountries();
    if (countries is List<Country>) add(AddCountriesEvent(countries));
  }

  // String get countryName {
  //   final country = state.countries.firstWhere((element) => element.id == locator<UsersBloc>().state.loggedUser.userCountryId,);
  // }

}
