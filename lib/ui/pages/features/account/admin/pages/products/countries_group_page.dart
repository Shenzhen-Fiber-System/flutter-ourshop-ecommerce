
import 'dart:developer';

import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class CountryGroupPage extends StatefulWidget {
  const CountryGroupPage({super.key});

  @override
  State<CountryGroupPage> createState() => _CountryGroupPageState();
}

class _CountryGroupPageState extends State<CountryGroupPage> {

  late ScrollController _scrollController;
  @override
  void initState() {  
    // dispacth the event to get the countries group
    fetchCountriesGroups();
    _scrollController = ScrollController()..addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(listener);
    super.dispose();
  }

  void listener() {
    final double threshold = _scrollController.position.maxScrollExtent * 0.1;
    if (_scrollController.position.pixels >= threshold && 
        context.read<ProductsBloc>().state.hasMore && 
        context.read<ProductsBloc>().state.productsStates != ProductsStates.loadingMore) {
      fetchCountriesGroups();
    }
  }

    void fetchCountriesGroups() {
    context.read<ProductsBloc>().add(AddFilteredCountriesGrupoEvent(
      page: context.read<ProductsBloc>().state.currentPage + 1,
      companyId:  context.read<CompanyBloc>().state.userCompany.id
    ));
  }


  final ValueNotifier<bool> _edit = ValueNotifier<bool>(false);
  final ValueNotifier<FilteredGroupCountries> selectedFilteredCountry = ValueNotifier<FilteredGroupCountries>(const FilteredGroupCountries(name: '', countries: [], id: '', countriesIds: null));
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: Text('${translations.countries_group} ${context.watch<ProductsBloc>().state.groupCountries.length}', style: theme.textTheme.titleLarge),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _edit,
        builder: (BuildContext context, value, Widget? child) {
          if(value){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    FormBuilderTextField(
                      initialValue: selectedFilteredCountry.value.name,
                      name: "name",
                      decoration: InputDecoration(
                        labelText: translations.name,
                        hintText: translations.name,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(translations.countries, style: theme.textTheme.titleMedium),
                    ),
                    const SizedBox(height: 10,),
                    FormBuilderDropdown(
                      name: "include_country", 
                      decoration: InputDecoration(
                        labelText: translations.choose_country,
                        hintText: translations.choose_country,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      items: context.read<CountryBloc>().state.countries.map((Country country) => DropdownMenuItem(
                        value: country.id,
                        child: Text(country.name),
                      )).toList(),
                      onChanged: (String? countryId) {
                        if (countryId != null) {
                          final Country selectedCountry = context.read<CountryBloc>().state.countries.firstWhere((country) => country.id == countryId,);
                          final updatedCountries = List<Country>.from(selectedFilteredCountry.value.countries);
                          if (!updatedCountries.contains(selectedCountry)) {
                            updatedCountries.add(selectedCountry);
                            selectedFilteredCountry.value = selectedFilteredCountry.value.copyWith(countries: updatedCountries,);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: selectedFilteredCountry,
                        builder: (BuildContext context, value, Widget? child) {
                          return ListView.builder(
                            itemCount: value.countries.length,
                            itemBuilder: (context, index) {
                              final Country country = value.countries[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: ListTile(
                                  title: Text(country.name),
                                  trailing: IconButton(
                                    onPressed: () {
                                      final updatedCountries = List<Country>.from(value.countries);
                                      updatedCountries.removeAt(index);
                                      selectedFilteredCountry.value = value.copyWith(
                                        countries: updatedCountries,
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )
              ),
            );
          }
          return child!;
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state.productsStates == ProductsStates.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
        
            if (state.productsStates == ProductsStates.error) {
              return Center(
                child: Text(translations.error, style: theme.textTheme.titleMedium),
              );
            }
        
            if (state.productsStates == ProductsStates.loaded && state.groupCountries.isEmpty) {
              return Center(
                child: Text(translations.no_coutnries_group, style: theme.textTheme.titleMedium),
              );
            }
        
            return SizedBox(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                controller: _scrollController,
                itemCount:state.hasMore
                  ? state.groupCountries.length + 1
                  : state.groupCountries.length,
                itemBuilder: (context, index) {
                  if (index == state.groupCountries.length) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  final FilteredGroupCountries groupCountry = state.groupCountries[index];
                  return Container(
                    
                    height: size.height * 0.1,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 3),
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(groupCountry.name, style: theme.textTheme.titleMedium),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                selectedFilteredCountry.value = groupCountry;
                                _edit.value = !_edit.value;
                              },
                              icon: const Icon(Icons.edit)
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                          width: size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: groupCountry.countries.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final Country country = groupCountry.countries[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text(country.name)
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }, 
              ),
            );
          },
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: selectedFilteredCountry,
        builder: (BuildContext context, value, Widget? child) {
          if(value.id.isEmpty){
            return const SizedBox.shrink();
          }
          return child!;
        },
        child: FloatingActionButton(
          child: const Icon(Icons.save, color: Colors.white,),
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              final Map<String, dynamic> data = {};
              data['name'] = _formKey.currentState!.value['name'];
              data['countries'] = selectedFilteredCountry.value.countries;
              log('ready to save : $data');
            }
            // _edit.value = !_edit.value;
          },
        ),
      ),
    );
  }
}