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
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppTheme.palette[1000],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => context.pop(),
        ),
        backgroundColor: AppTheme.palette[1000],
        title: Text(translations!.admin_page, style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: AppTheme.palette[550]!,
                    width: 1
                  )
                ),
                title: Text(option.title, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),),
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
            )
          else if (option == AdminOptions.MY_COMPANY)
            ElevatedButton(
            onPressed: () => context.push('/admin/option/my-company/WebEditor'),
            child:  Text(translations!.my_web_Site, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),)
          )
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
            return CustomFloatingActionButton(
              onClick: (){
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