import 'dart:developer';

import '../../../../pages.dart';
import 'my_company/my_company.dart';

  final AppLocalizations? translations = AppLocalizations.of(AppRoutes.globalContext!);

 
  class AdminOption {
    final String title;
    final Function onClick;
    

    AdminOption({
      required this.title,
      required this.onClick,
    });

    static List<AdminOption> options = [
      AdminOption(
        title: translations!.my_company,
        onClick: () => AppRoutes.globalContext!.push('/admin/option/my-company', extra: AdminOptions.MY_COMPANY),
      ),
      AdminOption(
        // option: AdminOptions.ORDERS,
        title: translations!.orders,
        onClick: () => AppRoutes.globalContext!.push('/admin/option/orders', extra: AdminOptions.ORDERS),
      ),
      AdminOption(
        // option: AdminOptions.PRODUCTS,
        title: translations!.products,
        onClick: () => AppRoutes.globalContext!.push('/admin/option/products', extra: AdminOptions.PRODUCTS),
      ),
      AdminOption(
        // option: AdminOptions.COMMUNICATION,
        title: translations!.comunication,
        onClick: () => print('Communication'),
      ),
    ];
  }


extension AdminOptionExtension on AdminOptions {
  String get title {
    switch (this) {
      case AdminOptions.MY_COMPANY:
        return 'My Company';
      case AdminOptions.ORDERS:
        return 'Orders';
      case AdminOptions.PRODUCTS:
        return 'Products';
      case AdminOptions.COMMUNICATION:
        return 'Communication';
      default:
        return '';
    }
  }
}


class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size  size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        height: size.height,
        width: size.width,
        child: ListView.builder(
          itemCount: AdminOption.options.length,
          itemBuilder: (context, index) {
            final AdminOption option = AdminOption.options[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                title: Text(option.title),
                onTap: () => option.onClick(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AdminOptionPage extends StatelessWidget {
  AdminOptionPage({super.key, required this.option});

  final AdminOptions option;

  final GlobalKey<FormBuilderState> _companyNameFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _generalFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _businessFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _socialMediaFormKey = GlobalKey<FormBuilderState>();


  String _getTitle(AdminOptions option, BuildContext context) {
    switch (option) {
      case AdminOptions.MY_COMPANY:
        return option.title;
      case AdminOptions.ORDERS:
        return '${option.title} - ${context.watch<OrdersBloc>().state.adminOrders.length}';
      case AdminOptions.PRODUCTS:
        return option.title;
      case AdminOptions.COMMUNICATION:
        return 'Communication';
      default:
        return '';
    }
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          _getTitle(option, context), 
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          if (option == AdminOptions.PRODUCTS)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.push('/admin/option/products/new', extra: AdminOptions.PRODUCTS),
            ),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (option) {
            case AdminOptions.MY_COMPANY:
              return MyCompany(
                companyNameFormKey: _companyNameFormKey, 
                generalFormKey: _generalFormKey,
                businessFormKey: _businessFormKey,
                socialMediaFormKey: _socialMediaFormKey,
              );
            case AdminOptions.ORDERS:
              return const AdminOrders();
            case AdminOptions.PRODUCTS:
              return const AdminProducts();
            // case AdminOptions.COMMUNICATION:
            //   return const _Communication();
            default:
              return SizedBox(
                child: Center(
                  child: Text('No option selected', style: theme.textTheme.bodyMedium,),
                ),
              );
          }
        }
      ),
      floatingActionButton: 
      (option == AdminOptions.MY_COMPANY) 
      ? BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: AppTheme.mainWebColor,
              onPressed: () {
                switch (state.selectedMyCompanyFormIndex) {
                  case 0:
                    if (_companyNameFormKey.currentState!.saveAndValidate() && _generalFormKey.currentState!.saveAndValidate()) {
                      final Map<String, dynamic> company = _companyNameFormKey.currentState!.value;
                      final Map<String, dynamic> general = _generalFormKey.currentState!.value;
                      final Map<String, dynamic> data = {...company, ...general};
                      log('general: $data');
                      
                    }
                    break;
                  case 1:
                    if (_companyNameFormKey.currentState!.saveAndValidate() && _businessFormKey.currentState!.saveAndValidate()) {
                      final Map<String, dynamic> company = _companyNameFormKey.currentState!.value;
                      final Map<String, dynamic> business = _businessFormKey.currentState!.value;
                      final Map<String, dynamic> data = {...company, ...business};
                      log('business: $data');
                    }
                    break;
                  case 2:
                    if (_companyNameFormKey.currentState!.saveAndValidate() && _socialMediaFormKey.currentState!.saveAndValidate()) {
                      final Map<String, dynamic> company = _companyNameFormKey.currentState!.value;
                      final Map<String, dynamic> socialMedia = _businessFormKey.currentState!.value;
                      final Map<String, dynamic> data = {...company, ...socialMedia};
                      log('social media: $data');
                    }
                    break;
                }
              },
              child: const Icon(Icons.save, color: Colors.white,),
            );
          },
        )
      : null
    );
  }
}