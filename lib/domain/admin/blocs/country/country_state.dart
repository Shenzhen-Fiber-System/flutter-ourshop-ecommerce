part of 'country_bloc.dart';

class CountryState extends Equatable {

  final List<Country> countries;
  const CountryState({
    this.countries = const [],
  });

  CountryState copyWith({
    List<Country>? countries,
  }) {
    return CountryState(
      countries: countries ?? this.countries,
    );
  }

  Country getCountryById(String id) {
    return countries.firstWhere(
      (country) => country.id == id, 
      orElse: () {
        return countries.isNotEmpty
        ? countries.first
        : const Country(id: '', name: '', iso: '', iso3: '', numCode: 0, phoneCode: 0, flagUrl: '');
      },
    );
  }
  
  @override
  List<Object> get props => [countries];
}
