import 'dart:developer';
import '../../../../../pages.dart';

class ExpansionPanelItem {
  ExpansionPanelItem({
    required this.header,
    required this.body,
    this.isExpanded = false,
  });

  String header;
  Widget body;
  bool isExpanded;
}

class MyCompany extends StatefulWidget {

  const MyCompany({
    super.key,  
    required this.companyNameFormKey, 
    required this.generalFormKey, 
    required this.businessFormKey, 
    required this.socialMediaFormKey, 
  });

  final GlobalKey<FormBuilderState> companyNameFormKey;
  final GlobalKey<FormBuilderState> generalFormKey;
  final GlobalKey<FormBuilderState> businessFormKey;
  final GlobalKey<FormBuilderState> socialMediaFormKey;

  @override
  State<MyCompany> createState() => _MyCompanyState();
}

class _MyCompanyState extends State<MyCompany> with TickerProviderStateMixin {

  final List<String> tabs = [
    translations!.general,
    translations!.business,
    translations!.social_media,
    translations!.banks
  ];


  final List<int> qtyProductLandingPage = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

  final List<String> socialMedias = [
    'Facebook',
    'Instagram',
    'Twitter',
    'Linkedin',
    'Pinterest',
    'Youtube',
    'Tiktok',
    'Snapchat',
    'Whatsapp',
  ];

  final List<Widget> _socialMediaForms = [];
  final List<ExpansionPanelItem> _bankPanels = [];

  late ScrollController _scrollController;
  late FocusNode _focusNodeAddress;
  late FocusNode _focusNodePhone;
  late FocusNode _focusNodeEmail;
  late FocusNode _focusNodeCountry;
  late FocusNode _focusNodeCountryCode;
  late FocusNode _focusNodeBusinessLine;
  late FocusNode _focusNodeTotalEmployees;
  late FocusNode _focusNodeWebsite;
  late FocusNode _focusNodeLegalOwner;

  late TabController _tabController;

  Future<void> getCompanyData() async {
    await context.read<CompanyBloc>().getCompanyById(context.read<UsersBloc>().state.loggedUser.companyId);
  }

  @override
  void initState() {
    getCompanyData();
    _tabController = TabController(length: tabs.length, vsync: this)..addListener(listener);
    _scrollController = ScrollController();
    _focusNodeAddress = FocusNode();
    _focusNodePhone = FocusNode();
    _focusNodeEmail = FocusNode();
    _focusNodeCountry = FocusNode();
    _focusNodeCountryCode = FocusNode();
    _focusNodeBusinessLine = FocusNode();
    _focusNodeTotalEmployees = FocusNode();
    _focusNodeWebsite = FocusNode();
    _focusNodeLegalOwner = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(listener);
    _scrollController.dispose();
    _focusNodeAddress.dispose();
    _focusNodePhone.dispose();
    _focusNodeEmail.dispose();
    _focusNodeCountry.dispose();
    _focusNodeCountryCode.dispose();
    _focusNodeBusinessLine.dispose();
    _focusNodeTotalEmployees.dispose();
    _focusNodeWebsite.dispose();
    _focusNodeLegalOwner.dispose();
    super.dispose();
  }

  void listener() {
    if (_tabController.indexIsChanging) {
      context.read<CompanyBloc>().addSelectedCompanyForm(_tabController.index);
    }
  }

  @override
  void deactivate() {
    context.read<CompanyBloc>().add(const AddUserCompanyEvent(Company(id: '',)));
    super.deactivate();
  }

  void _addSocialMediaForm() {
    setState(() {
      _socialMediaForms.add(_buildSocialMediaFormWidget());
    });
  }

  void _addBankPanel() {
    setState(() {
      _bankPanels.add(ExpansionPanelItem(
        header: 'Bank ${_bankPanels.length + 1}',
        body: _buildBankFormWidget(_bankPanels.length),
        isExpanded: false,
      ));
    });
  }

  void _removeBankPanel(int index) {
    setState(() {
      _bankPanels.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      height: size.height,
      width: size.width,
      child: BlocBuilder<CompanyBloc, CompanyState>(
        buildWhen: (previous, current) => 
          previous.selectedMyCompanyFormIndex != current.selectedMyCompanyFormIndex 
          || previous.userCompany != current.userCompany 
          || previous.status != current.status
          || previous.logoStatus != current.logoStatus,

        builder: (context, state) {
          if (state.status == CompanyStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                      child: Text(translations!.update_prop(translations!.company), style: theme.textTheme.titleLarge,),
                    )
                  ),
                  const SizedBox(height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: FormBuilder(
                      key: widget.companyNameFormKey,
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: 'company_name',
                            initialValue: state.userCompany.name,
                            style: theme.textTheme.labelLarge?.copyWith(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: translations!.company_name,
                              hintText: translations!.company_name,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          const SizedBox(height: 10.0,),
                          Container(
                            height: 200,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5.0),
                              image: state.selectedLogoPath.isNotEmpty
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(state.selectedLogoPath),)
                                  ) 
                                : null
                            ),
                            child: state.logoStatus == CompanyLogoStatus.loading 
                                    ? const Center(child: CircularProgressIndicator.adaptive())
                                    : state.selectedLogoPath.isNotEmpty 
                                      ? null
                                      : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.image, size: 50.0, color: Colors.grey,),
                                          Text(translations!.company_logo_dimension, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),),
                                          Text(translations!.supported_formats , style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),),
                                        ],
                                      )
                          ),
                          ElevatedButton(
                            style: theme.elevatedButtonTheme.style?.copyWith(backgroundColor: WidgetStateProperty.all(AppTheme.palette[1000])),
                            onPressed: state.logoStatus == CompanyLogoStatus.loading ? null : () => context.read<CompanyBloc>().chooseCompanyLogo(), 
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.upload, color: Colors.white,),
                                const SizedBox(width: 10.0,),
                                Text(translations!.upload_logo, style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    height: size.height,
                    width: double.maxFinite,
                    child: DefaultTabController(
                      length: tabs.length, 
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabAlignment: TabAlignment.center,
                            isScrollable: true,
                            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _GeneralForm(
                                  focusNodeAddress: _focusNodeAddress, 
                                  focusNodePhone: _focusNodePhone, 
                                  theme: theme, 
                                  focusNodeEmail: _focusNodeEmail, 
                                  focusNodeCountry: _focusNodeCountry, 
                                  focusNodeCountryCode: _focusNodeCountryCode, 
                                  focusNodeBusinessLine: _focusNodeBusinessLine, 
                                  focusNodeTotalEmployees: _focusNodeTotalEmployees, 
                                  focusNodeWebsite: _focusNodeWebsite, 
                                  focusNodeLegalOwner: _focusNodeLegalOwner,
                                  formKey: widget.generalFormKey,
                                ),
                                _Business(
                                  businessKey: widget.businessFormKey,
                                  theme: theme, 
                                  qtyProductLandingPage: qtyProductLandingPage
                                ),
                                //social media
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: size.width,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _addSocialMediaForm();
                                          }, 
                                          child: Text(translations!.add_social_media, style: theme.textTheme.labelMedium?.copyWith(color: Colors.white),),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0,),
                                      ..._socialMediaForms
                                    ],
                                  ),
                                ),
                                // banks
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: size.width,
                                        child: ElevatedButton(
                                          onPressed: _addBankPanel,
                                          child: Text('Add Bank', style: theme.textTheme.labelMedium?.copyWith(color: Colors.white),),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0,),
                                      ExpansionPanelList(
                                        expansionCallback: (int index, bool isExpanded) {
                                          log('message: $isExpanded');
                                          setState(() {
                                            _bankPanels[index].isExpanded = isExpanded;
                                          });
                                        },
                                        children: _bankPanels.map<ExpansionPanel>((ExpansionPanelItem item) {
                                          return ExpansionPanel(                                            
                                            headerBuilder: (BuildContext context, bool isExpanded) {
                                              return ListTile(
                                                shape: theme.inputDecorationTheme.border?.copyWith(borderSide: BorderSide.none),
                                                title: Text(item.header, style: theme.textTheme.titleLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.w400),),
                                              );
                                            },
                                            body: item.body,
                                            isExpanded: item.isExpanded,
                                          );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    )
                  )
                ],
              ),
            );
        },
      ),
    );
  }

  Widget _buildSocialMediaFormWidget() {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.4,
          child: FormBuilderDropdown(
            name: 'social_media_${_socialMediaForms.length}',
            style: theme.textTheme.labelLarge,
            decoration: const InputDecoration(
              labelText: 'Social Media',
              hintText: 'Social Media',
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]), 
            items: socialMedias.map((socialMedia) => DropdownMenuItem(
              value: socialMedia,
              child: Text(socialMedia, style: theme.textTheme.labelMedium?.copyWith(color: Colors.black)),
            )).toList(),
          ),
        ),
        const SizedBox(width: 10.0,),
        SizedBox(
          width: size.width * 0.4,
          child: FormBuilderTextField(
            name: 'social_media_url_${_socialMediaForms.length}',
            style: theme.textTheme.labelLarge,
            decoration: const InputDecoration(
              labelText: 'Social Media URL',
              hintText: 'Social Media URL',
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _socialMediaForms.removeAt(_socialMediaForms.length - 1);
            });
          }, 
          icon: const Icon(Icons.delete)
        )
      ],
    );
  }

  Widget _buildBankFormWidget(int index){
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        FormBuilderTextField(
          name: 'bank_name',
          style: theme.textTheme.labelLarge,
          decoration: const InputDecoration(
            labelText: 'Bank Name',
            hintText: 'Bank Name',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        const SizedBox(height: 10.0,),
        FormBuilderTextField(
          name: 'bank_account_number',
          style: theme.textTheme.labelLarge,
          decoration: const InputDecoration(
            labelText: 'Bank Account Number',
            hintText: 'Bank Account Number',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        const SizedBox(height: 10.0,),
        FormBuilderTextField(
          name: 'bank_account_name',
          style: theme.textTheme.labelLarge,
          decoration: const InputDecoration(
            labelText: 'Bank Account Name',
            hintText: 'Bank Account Name',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        const SizedBox(height: 10.0,),
        FormBuilderTextField(
          name: 'bank_branch',
          style: theme.textTheme.labelLarge,
          decoration: const InputDecoration(
            labelText: 'Bank Branch',
            hintText: 'Bank Branch',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        const SizedBox(height: 10.0,),
        FormBuilderTextField(
          name: 'bank_swift_code',
          style: theme.textTheme.labelLarge,
          decoration: const InputDecoration(
            labelText: 'Bank Swift Code',
            hintText: 'Bank Swift Code',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        IconButton(
          onPressed: () => _removeBankPanel(index),
          icon: const Icon(Icons.delete)
        )
      ],
    );
  }
}

class _Business extends StatelessWidget {
  const _Business({
    required this.theme,
    required this.qtyProductLandingPage,
    required this.businessKey
  });

  final ThemeData theme;
  final List<int> qtyProductLandingPage;
  final GlobalKey<FormBuilderState> businessKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: businessKey,
        child: Column(
          children: [
            const SizedBox(height: 10.0,),
            FormBuilderDropdown(
              name: 'main_category',
              style: theme.textTheme.labelLarge,
              decoration: InputDecoration(
                labelText: translations!.main_category,
                hintText: translations!.main_category,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]), 
              // initialValue: context.read<ProductsBloc>().state.categories.firstWhere((category) => category.id == state.userCompany.mainCategoryId).name,
              items: context.read<ProductsBloc>().state.categories.map((category) => DropdownMenuItem(
                value: category.name,
                child: Text(category.name, style: theme.textTheme.labelMedium?.copyWith(color: Colors.black),),
              )).toList(),
            ),
            const SizedBox(height: 10.0,),
            FormBuilderDropdown(
              name: 'qty_landing_page',
              style: theme.textTheme.labelLarge,
              decoration: InputDecoration(
                labelText: translations!.products_landing_page,
                hintText: translations!.products_landing_page,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]), 
              initialValue:context.watch<CompanyBloc>().state.userCompany.qtyProductLandingPage,
              items: qtyProductLandingPage.map((qty) => DropdownMenuItem(
                value: qty,
                child: Text('$qty', style: theme.textTheme.labelMedium?.copyWith(color: Colors.black)),
              )).toList(),
            ),
            const SizedBox(height: 10.0,),
            FormBuilderTextField(
              name: 'company_subdomain',
              style: theme.textTheme.labelLarge,
              initialValue:context.watch<CompanyBloc>().state.userCompany.subdomain,
              decoration: InputDecoration(
                labelText: 'Subdomain',
                hintText: 'Subdomain',
                suffix: Text('.ourshop.shop', style: theme.textTheme.labelMedium?.copyWith(color: Colors.black),),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _GeneralForm extends StatelessWidget {
  _GeneralForm({
    required FocusNode focusNodeAddress,
    required FocusNode focusNodePhone,
    required this.theme,
    required FocusNode focusNodeEmail,
    required FocusNode focusNodeCountry,
    required FocusNode focusNodeCountryCode,
    required FocusNode focusNodeBusinessLine,
    required FocusNode focusNodeTotalEmployees,
    required FocusNode focusNodeWebsite,
    required FocusNode focusNodeLegalOwner, 
    required this.formKey,
  }) : 
  _focusNodeAddress = focusNodeAddress, 
  _focusNodePhone = focusNodePhone, 
  _focusNodeEmail = focusNodeEmail,
  _focusNodeCountry = focusNodeCountry, 
  _focusNodeCountryCode = focusNodeCountryCode, 
  _focusNodeBusinessLine = focusNodeBusinessLine, 
  _focusNodeTotalEmployees = focusNodeTotalEmployees, 
  _focusNodeWebsite = focusNodeWebsite, 
  _focusNodeLegalOwner = focusNodeLegalOwner;

  final FocusNode _focusNodeAddress;
  final FocusNode _focusNodePhone;
  final ThemeData theme;
  final FocusNode _focusNodeEmail;
  final FocusNode _focusNodeCountry;
  final FocusNode _focusNodeCountryCode;
  final FocusNode _focusNodeBusinessLine;
  final FocusNode _focusNodeTotalEmployees;
  final FocusNode _focusNodeWebsite;
  final FocusNode _focusNodeLegalOwner;

  final GlobalKey<FormBuilderState> formKey;
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: formKey,
        child: BlocBuilder<CompanyBloc, CompanyState>(
          buildWhen: (previous, current) => 
          previous.selectedMyCompanyFormIndex != current.selectedMyCompanyFormIndex 
          || previous.userCompany != current.userCompany 
          || previous.status != current.status,
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 10.0,),
                FormBuilderTextField(
                  initialValue: state.userCompany.address,
                  focusNode: _focusNodeAddress,
                  onEditingComplete: () => _focusNodePhone.requestFocus(),
                  textInputAction: TextInputAction.next,
                  name: 'company_address',
                  style: theme.textTheme.labelLarge,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: 'Address',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 10.0,),
                FormBuilderTextField(
                  initialValue: state.userCompany.phoneNumber,
                  focusNode: _focusNodePhone,
                  onEditingComplete: () => _focusNodeEmail.requestFocus(),
                  textInputAction: TextInputAction.next,
                  name: 'company_phone', 
                  style: theme.textTheme.labelLarge,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    hintText: 'Phone',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 10.0,),
                FormBuilderTextField(
                  initialValue: state.userCompany.email,
                  focusNode: _focusNodeEmail,
                  onEditingComplete: () => _focusNodeCountry.requestFocus(),
                  textInputAction: TextInputAction.next,
                  name: "company_email", 
                  style: theme.textTheme.labelLarge,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                    
                  ]),
                ),
                const SizedBox(height: 10.0,),
                FormBuilderDropdown(
                  focusNode: _focusNodeCountry,
                  name: 'company_country',
                  // initialValue: state.userCompany.countryId != null ?  context.read<CountryBloc>().state.getCountryById(state.userCompany.countryId!).id : '',
                  initialValue: _getCountry(state, context),
                  style: theme.textTheme.labelLarge,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    hintText: 'Country',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  items: context.read<CountryBloc>().state.countries.map((country) => DropdownMenuItem(
                    value: country.id,
                    child: Text(country.name),
                  )).toList(),
                  onChanged: (countryId) {
                    final Country country = context.read<CountryBloc>().state.getCountryById(countryId!);
                    _codeController.text = '+${country.numCode}';
                    _focusNodeCountryCode.requestFocus();
                  },
                ),
                const SizedBox(height: 10.0,),
                FormBuilderTextField(
                  readOnly: true,
                  // initialValue: state.userCompany.countryId != null ? '+${context.read<CountryBloc>().state.getCountryById(state.userCompany.countryId!).phoneCode.toString()}' : '',
                  controller: _codeController,
                  // initialValue: _codeController.text,
                  focusNode: _focusNodeCountryCode,
                  onEditingComplete: () => _focusNodeBusinessLine.requestFocus(),
                  textInputAction: TextInputAction.next,
                  name: 'company_country_code',
                  style: theme.textTheme.labelLarge,
                  decoration: const InputDecoration(
                    labelText: 'Country Code',
                    hintText: 'Country Code',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ]),
                ),
                const SizedBox(height: 10.0,),
                FormBuilderTextField(
                  initialValue: state.userCompany.advantages,
                  focusNode: _focusNodeBusinessLine,
                  onEditingComplete: () => _focusNodeTotalEmployees.requestFocus(),
                  textInputAction: TextInputAction.next,
                  name: 'company_business_line',
                  style: theme.textTheme.labelLarge,
                  decoration: const InputDecoration(
                    labelText: 'Business Line',
                    hintText: 'Business Line',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 10.0,),
                FormBuilderTextField(
                  initialValue: state.userCompany.totalEmployee.toString(),
                  focusNode: _focusNodeTotalEmployees,
                  onEditingComplete: () => _focusNodeWebsite.requestFocus(),
                  textInputAction: TextInputAction.next,
                  name: 'company_office_size',
                  style: theme.textTheme.labelLarge,
                  decoration: const InputDecoration(
                    labelText: 'Office Size',
                    hintText: 'Office Size',
                  ),
                  validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]
                  ),
                ),
                const SizedBox(height: 10.0,),
                FormBuilderTextField(
                  initialValue: state.userCompany.websiteUrl,
                  focusNode: _focusNodeWebsite,
                  onEditingComplete: () => _focusNodeLegalOwner.requestFocus(),
                  textInputAction: TextInputAction.next,
                  name: 'company_website',
                  style: theme.textTheme.labelLarge,
                  decoration: const InputDecoration(
                    labelText: 'Website',
                    hintText: 'Website',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 10.0,),
                FormBuilderTextField(
                  initialValue: state.userCompany.legalOwner,
                  focusNode: _focusNodeLegalOwner,
                  textInputAction: TextInputAction.done,
                  name: 'company_legal_owner',
                  style: theme.textTheme.labelLarge,
                  decoration: const InputDecoration(
                    labelText: 'Legal Owner',
                    hintText: 'Legal Owner',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ]
            );
          },
        ),
      ),
    );
  }
    String _getCountry(CompanyState state , BuildContext context) {
      if(state.userCompany.countryId != null ){
        _codeController.text = '+${context.read<CountryBloc>().state.getCountryById(state.userCompany.countryId!).numCode}';
        return context.read<CountryBloc>().state.getCountryById(state.userCompany.countryId!).id;
      }
      return '';
    }
    

}