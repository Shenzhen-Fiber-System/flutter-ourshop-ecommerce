part of 'country_bloc.dart';

sealed class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class AddCountriesEvent extends CountryEvent {
  final List<Country> countries;
  const AddCountriesEvent(this.countries);

  @override
  List<Object> get props => [countries];
}
