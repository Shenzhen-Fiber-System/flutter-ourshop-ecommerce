// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';
import '../../pages.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> with TickerProviderStateMixin {

  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _translateAnimation;
  late Animation<double> _opacityAnimation;
  late AnimationController _componentAnimationController;

  late Animation<double> _avatarButtonTranslation;


  void listener() {
    if (_scrollController.position.pixels >= 58.0) {
      _animationController.forward();
    } else if (_scrollController.position.pixels < 58.0) {
      _animationController.reverse();
    }
  }

  void animationControllerListener(){
    _translateAnimation.addListener((){
      if(_translateAnimation.value == 50.0){
        _componentAnimationController.forward();
        
      } else if (_translateAnimation.value == 0.0) {
        log('jshdfs${_avatarButtonTranslation.value}');
        _componentAnimationController.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _componentAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _translateAnimation = Tween<double>(begin: 0.0, end: 50.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _avatarButtonTranslation = Tween<double>(begin: 50.0, end: 0.0).animate(CurvedAnimation(parent: _componentAnimationController, curve: Curves.linear));
    

    _scrollController.addListener(listener);
    _animationController.addListener(animationControllerListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(listener);
    _animationController.removeListener(animationControllerListener);
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations =  AppLocalizations.of(context)!;
    final ThemeData theme =  Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final loggedUser = context.watch<UsersBloc>().state.loggedUser;

    final _personalInformationTextTheme = theme.textTheme.labelMedium?.copyWith(color: Colors.grey.shade500);


    void showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: size.height * 0.50,
            color: Colors.white,
            child: const Center(
              child: Text('This is a Bottom Sheet'),
            ),
          );
        },
      );
    }

    final List<SettignsOptions> personalInformation = [
      SettignsOptions(
        title: 'Name', 
        mode: SettingsOptionsMode.Name,
        onClick: () => showBottomSheet(context),
        data: Text(loggedUser.name.toUpperCase(), style: _personalInformationTextTheme)
      ),
      SettignsOptions(
        title: 'Last Name', 
        mode: SettingsOptionsMode.LastName,
        onClick: () => showBottomSheet(context),
        data: Text(loggedUser.lastName.toUpperCase(), style: _personalInformationTextTheme)
      ),
      SettignsOptions(
        title: 'Email', 
        mode: SettingsOptionsMode.Email,
        onClick: () => showBottomSheet(context),
        data: Text(loggedUser.email, style: _personalInformationTextTheme)
      ),
      SettignsOptions(
        title: 'Phone', 
        mode: SettingsOptionsMode.Phone,
        onClick: () => showBottomSheet(context),
        data: Text('${loggedUser.userPhoneNumberCode} ${loggedUser.userPhoneNumber}', style: _personalInformationTextTheme)
      ),
      SettignsOptions(
        title: 'Country', 
        mode: SettingsOptionsMode.Phone,
        onClick: () => showBottomSheet(context),
        data: Text(loggedUser.userCountryName, style: _personalInformationTextTheme)
      ),
    ];

    final List<SettignsOptions> orderHistory = [
      SettignsOptions(
        title: 'All orders', 
        mode: SettingsOptionsMode.AllOrders,
        onClick: () => showBottomSheet(context)
      ),
      SettignsOptions(
        title: 'Processing', 
        mode: SettingsOptionsMode.Processing,
        onClick: () => showBottomSheet(context)
      ),
      SettignsOptions(
        title: 'Shipped', 
        mode: SettingsOptionsMode.Shipped,
        onClick: () => showBottomSheet(context)
      ),
      SettignsOptions(
        title: 'Delivered', 
        mode: SettingsOptionsMode.Delivered,
        onClick: () => showBottomSheet(context)
      ),
      SettignsOptions(
        title: 'Cancelled', 
        mode: SettingsOptionsMode.Cancelled,
        onClick: () => showBottomSheet(context)
      ),
      SettignsOptions(
        title: 'Returned', 
        mode: SettingsOptionsMode.Returned,
        onClick: () => showBottomSheet(context)
      ),
    ];

    final List<SettignsOptions> settings = [
      SettignsOptions(
        title: translations.deliver_to, 
        mode: SettingsOptionsMode.Deliver,
        onClick: () => showBottomSheet(context)
      ),
      SettignsOptions(
        title: translations.currency, 
        mode: SettingsOptionsMode.Currency,
        onClick: () => showBottomSheet(context)
      ),
      SettignsOptions(
        title: translations.language, 
        mode: SettingsOptionsMode.Language,
        onClick: () => showBottomSheet(context)
      ),
      SettignsOptions(
        title: 'logout', 
        mode: SettingsOptionsMode.Logout,
        onClick: (){}
      ),
    ];

    List<AccountOptions> sections = [
      AccountOptions(
        label: 'Personal Information', 
        mode: AccountOptionsMode.PersonalInformation,
        sectionOptions: personalInformation,
        labelIcon: IconButton(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            visualDensity: VisualDensity.compact,
            iconSize: const WidgetStatePropertyAll(15.0),
            backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300)
          ),
          onPressed: () async {
            final LoggedUser loggedUser = context.read<UsersBloc>().state.loggedUser;
            await PersonalInformationDialog(
              initialData: {
                'name': loggedUser.name,
                'lastName': loggedUser.lastName,
                'email': loggedUser.email,
                'phoneNumberCode': loggedUser.userPhoneNumberCode,
                'phoneNumber': loggedUser.userPhoneNumber,
                'countryId': loggedUser.userCountryId,
                // "rolesIds": [loggedUser.roles],
              }
            ).showAlertDialog(context, translations, theme);
          },
          icon: const Icon(Icons.edit_rounded, color: Colors.grey),
          
        )
      ),
      AccountOptions(
        label: 'Shipping Address', 
        mode: AccountOptionsMode.ShippingAddress,
        sectionOptions: const [],
        labelIcon: IconButton(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            visualDensity: VisualDensity.compact,
            iconSize: const WidgetStatePropertyAll(15.0),
            backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300)
          ),
          onPressed: () async {
            await ShippingAddressDialog(
              type: ShippingAddressDialogType.ADD
            ).showAlertDialog(context, translations, theme);
          }, 
          icon: const Icon(Icons.add, color: Colors.grey)
        )
      ),
      AccountOptions(
        label: 'Payment Methods', 
        mode: AccountOptionsMode.PaymentMethods,
        sectionOptions: const [],
        labelIcon: IconButton(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            visualDensity: VisualDensity.compact,
            iconSize: const WidgetStatePropertyAll(15.0),
            backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300)
          ),
          onPressed: () {
            
          }, 
          icon: const Icon(Icons.add, color: Colors.grey)
        )
      ),
      AccountOptions(
        label: 'Order History',
        mode: AccountOptionsMode.OrderHistory,
        sectionOptions: orderHistory,
        labelIcon: IconButton(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            visualDensity: VisualDensity.compact,
            iconSize: const WidgetStatePropertyAll(15.0),
            backgroundColor: WidgetStatePropertyAll(Colors.grey.shade100)
          ),
          onPressed: null,
          icon: Icon(Icons.add, color:Colors.grey.shade100)
        )
      ),
      AccountOptions(
        label: 'Settings',
        mode: AccountOptionsMode.Settings,
        sectionOptions: settings,
        labelIcon: IconButton(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            visualDensity: VisualDensity.compact,
            iconSize: const WidgetStatePropertyAll(15.0),
            backgroundColor: WidgetStatePropertyAll(Colors.grey.shade100)
          ),
          onPressed: null,
          icon: Icon(Icons.add, color:Colors.grey.shade100)
        )
      ),
    ];

    return Container(
      color: Colors.grey.shade100,
      height: double.maxFinite,
      width: double.maxFinite,
      child:  CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            leadingWidth: double.maxFinite,
            expandedHeight: 50.0,
            floating: false,
            pinned: true,
            leading: AnimatedBuilder(
              animation: Listenable.merge([
                _animationController,
                _componentAnimationController
              ]),
              builder: (BuildContext context, Widget? child) {
                if (_translateAnimation.isCompleted) {
                  return Transform.translate(
                    offset: Offset(0.0, _avatarButtonTranslation.value),
                    child: const _AvatarButton()
                  );
                }
                return Transform.translate(
                  offset: Offset(0.0, _translateAnimation.value * -1),
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: child
                  )
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                width: size.width * 0.5,
                child: Autocomplete(
                  initialValue: TextEditingValue.empty,
                  fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onTapOutside: (event) => focusNode.unfocus(),
                      style: theme.textTheme.labelMedium?.copyWith(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    );
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Material(
                      elevation: 4.0,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Country option = options.toList()[index];
                          return ListTile(
                            selected: false,
                            tileColor: Colors.white,
                            shape: theme.listTileTheme.copyWith(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))
                            ).shape,
                            title: Text(option.name, style: theme.textTheme.titleMedium,),
                            trailing: Text(option.iso3, style: theme.textTheme.labelLarge,),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage('${dotenv.env['FLAG_URL']}${option.flagUrl}'),
                            ),
                            onTap: () => onSelected(option),
                          );
                        }, separatorBuilder: (BuildContext context, int index)  => Divider(
                            height: 0.0,
                            indent: 15.0,
                            endIndent: 15.0,
                            color: Colors.grey.shade300,
                          )
                      ),
                    );
                  },
                  optionsBuilder: (textEditingValue) {
                    final List<Country> currencies = List.from(context.read<CountryBloc>().state.countries);
                    return currencies.where((element) => (element.name.trim().toLowerCase().startsWith(textEditingValue.text) || element.iso3.trim().toLowerCase().startsWith(textEditingValue.text))).toList();
                  }, 
                  onSelected: (value){},
                ),
              ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 60.0,
              color: Colors.white,
              child: const _AvatarButton(),
            )
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final AccountOptions accountSections = sections[index];
                return _AccountSecction(
                  accountSections: accountSections, 
                  theme: theme, 
                  size: size, 
                  translations: translations,
                );
              },
              childCount: sections.length,
            ),
          ),
        ],
      )
    );
  }
}

class _AccountSecction extends StatelessWidget {
  const _AccountSecction({
    required this.accountSections,
    required this.theme,
    required this.size, 
    required this.translations,
  });

  final AccountOptions accountSections;
  final ThemeData theme;
  final Size size;
  final AppLocalizations translations;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 5,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(accountSections.label, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),),
                if(accountSections.labelIcon != null) accountSections.labelIcon!,
              ],
            ),
          ),
        ),
        Container(
          height: size.height * 0.30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
          ),
          width: size.width,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child:  SingleChildScrollView(
            child: Column(
              children: _renderList(accountSections.mode, context, translations),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _renderList(AccountOptionsMode mode, BuildContext context, AppLocalizations translations) {

    switch (mode) {
      
      case AccountOptionsMode.ShippingAddress:
        if (context.read<UsersBloc>().state.shippingAddresses.isEmpty) {
          return [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text(translations.no_shipping_methods, style: theme.textTheme.titleMedium,))
            )
          ];
        } 
        return context.read<UsersBloc>().state.shippingAddresses.map((address){
          return Column(
            children: [
              RadioListTile(
                selected: false,
                tileColor: Colors.white,
                shape: theme.listTileTheme.copyWith(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))
                ).shape,
                secondary: IconButton(
                  onPressed: () {
                    
                  }, 
                  icon: const  Icon(Icons.edit, size: 15, color: Colors.grey,)
                ),
                title: Text(address.fullName),
                subtitle: Text('${address.address}, ${address.municipality}, ${address.state}, ${address.country}', style: TextStyle(color: Colors.grey.shade500, fontSize: 10.0)), 
                value: address.id, 
                groupValue: context.read<UsersBloc>().state.selectedShippingAddress.id, 
                onChanged: (value) {} //context.read<UsersBloc>().addSelectedShippingAddress(ShippingAddress.shippingAddresses.firstWhere((element) => element.id == value)),
              ),
              const Divider(indent: 30, endIndent: 30,)
            ],
          );
        }).toList();
      case AccountOptionsMode.PaymentMethods:
        if (context.read<UsersBloc>().state.cards.isEmpty) {
          return [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text(translations.no_payment_methods, style: theme.textTheme.titleMedium,))
            )
          ];
        } 
        return context.read<UsersBloc>().state.cards.map((card){
          return Column(
            children: [
              RadioListTile(
                value: card.id, 
                groupValue: context.read<UsersBloc>().state.selectedCard.id, 
                onChanged: (value) => context.read<UsersBloc>().addSelectedCard(context.read<UsersBloc>().state.cards.firstWhere((element) => element.id == value)),
                title: Align(
                  alignment: Alignment.centerRight,
                    child: Text( Helpers.maskCardNumber(card.cardNumber), style: const TextStyle(color: Colors.black, fontSize: 12.0)
                  )
                ),
                subtitle: Align(
                  alignment: Alignment.centerRight,
                  child: Text('exp ${card.expirationDate}', style: TextStyle(color: Colors.grey.shade500, fontSize: 10.0))
                ),
              ),
              const Divider(indent: 30, endIndent: 30,)
            ],
          );
        }).toList();
      // case AccountOptionsMode.OrderHistory:
      //   return [];
      default:
       return accountSections.sectionOptions.map((SettignsOptions option) {
          if (option.mode == SettingsOptionsMode.Logout) {
            return SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () => context.go('/'),
                child: Text(translations.logout, style: theme.textTheme.bodyMedium,)
              ),
            );

          }
          return ListTile(
            selected: false,
            tileColor: Colors.white,
            titleTextStyle: theme.textTheme.labelMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            shape: theme.listTileTheme.copyWith(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))
            ).shape,
            title: Text(option.title),
            onTap: () => option.onClick(),
            trailing: option.data ?? const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 15.0),
          );
        }).toList();
    }
  }

}

class _AvatarButton extends StatelessWidget {
  const _AvatarButton();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<UsersBloc, UsersState>(
      buildWhen: (previous, current) => previous.loggedUser != current.loggedUser,
      builder: (context, state) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:5.0), 
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text('${state.loggedUser.name[0].toUpperCase()}${state.loggedUser.lastName[0]}', style: theme.textTheme.labelLarge),
              ),
            ),
            Text(state.loggedUser.name, style: theme.textTheme.labelLarge, ),
          ],
        );
      },
    );
  }
}

class AccountOptions extends Equatable {

  final String label;
  final Widget? labelIcon;
  final List<SettignsOptions> sectionOptions;
  final AccountOptionsMode mode;

  const AccountOptions({required this.label, required this.sectionOptions, this.labelIcon, required this.mode, });

  AccountOptions copyWith({
    String? label,
    List<SettignsOptions>? sectionOptions,
    Widget? labelIcon,
    AccountOptionsMode? mode,
  }) {
    return AccountOptions(
      label: label ?? this.label,
      sectionOptions: sectionOptions ?? this.sectionOptions,
      labelIcon: labelIcon ?? this.labelIcon, 
      mode: mode ?? this.mode,
    );
  }
  
  @override
  List<Object?> get props => [
    label,
    sectionOptions,
    labelIcon,
    mode,
  ];



}

class SettignsOptions{
  final String title;
  final SettingsOptionsMode mode;
  final Function onClick;
  final Widget? data;

  const SettignsOptions({
    required this.title,
    required this.mode,
    required this.onClick,
    this.data
  });

}

enum SettingsOptionsMode{
  Language,
  Currency,
  Deliver,
  AllOrders,
  Processing,
  Shipped,
  Delivered,
  Cancelled,
  Returned,
  Name,
  LastName,
  Email,
  Phone,
  Country,
  Logout
}

enum AccountOptionsMode{
  PersonalInformation,
  ShippingAddress,
  PaymentMethods,
  OrderHistory,
  Settings,
}