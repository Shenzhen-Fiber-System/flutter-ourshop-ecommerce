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

  Country getCountryById(String id) => countries.firstWhere((country) => country.id == id);
  
  @override
  List<Object> get props => [countries];
}
