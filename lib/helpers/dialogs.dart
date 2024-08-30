import 'dart:developer';

import '../ui/pages/pages.dart';

sealed class AlertDialogs {

  final double space = 20.0;
  
  Future showAlertDialog(BuildContext context, AppLocalizations translations, ThemeData theme) async {}
  
}

class PersonalInformationDialog extends AlertDialogs {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final Map<String, dynamic>? initialData;
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> showConfirmPassword = ValueNotifier<bool>(true);
  final TextEditingController _codeController;

  PersonalInformationDialog({this.initialData})
    : _codeController = TextEditingController(text: initialData?['phoneNumberCode'] ?? '');

  @override
  Future<void> showAlertDialog(BuildContext context, AppLocalizations translations, ThemeData theme,) async {
    final TextStyle inputValueStyle = theme.textTheme.bodyMedium!.copyWith(color: Colors.black);
    final Size size = MediaQuery.of(context).size;
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: theme.dialogTheme.backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: FormBuilder(
             key: _formKey,
             initialValue: initialData ?? {},
             child: Column(
               children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CloseButton()
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(translations.update_personal_information, style: theme.textTheme.titleMedium),
                    ),
                  ],
                 ),
                 FormBuilderTextField(
                   style: inputValueStyle,
                   textInputAction: TextInputAction.next,
                   name: "email",
                   decoration: InputDecoration(
                     labelText: translations.email,
                     hintText: translations.placeholder(translations.email.toLowerCase()),
                     
                   ),
                   validator: FormBuilderValidators.compose([
                     FormBuilderValidators.required(),
                     FormBuilderValidators.email(),
                   ]),
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                 ),
                 SizedBox(height: space,),
                 FormBuilderTextField(
                   style: inputValueStyle,
                   textInputAction: TextInputAction.next,
                   name: "name",
                   decoration: InputDecoration(
                     labelText: translations.name,
                     hintText: translations.placeholder(translations.name.toLowerCase()),
                   ),
                   validator: FormBuilderValidators.compose([
                     FormBuilderValidators.required(),
                   ]),
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                 ),
                 SizedBox(height: space,),
                 FormBuilderTextField(
                   style: inputValueStyle,
                   textInputAction: TextInputAction.next,
                   name: "lastName",
                   decoration: InputDecoration(
                     labelText: translations.last_name,
                     hintText: translations.placeholder(translations.last_name.toLowerCase()),
                   ),
                   validator: FormBuilderValidators.compose([
                     FormBuilderValidators.required(),
                   ]),
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                 ),
                 SizedBox(height: space,),
                 FormBuilderDropdown(
                   name: "countryId",
                   decoration: InputDecoration(
                     labelText: translations.country,
                     hintText: translations.choose_country
                   ),
                   items: context.watch<CountryBloc>().state.countries.map((Country country) => DropdownMenuItem(
                     value: country.id,
                     child: Row(
                       children: [
                         FlagPhoto(country: country,),
                         Padding(
                           padding: const EdgeInsets.only(left:10.0),
                           child: Text(country.name, style: theme.textTheme.bodySmall,),
                         ),
                       ],
                     ),
                   )).toList(),
                   onChanged: (countryId) {
                     final Country country = context.read<CountryBloc>().state.getCountryById(countryId!);
                     _codeController.text = '+${country.numCode}';
                   }
                   
                 ),
                 SizedBox(height: space,),
                 Row(
                   children: [
                     SizedBox(
                       width: size.width * 0.2,
                       child: FormBuilderTextField(
                         controller: _codeController,
                         name: "phoneNumberCode",
                         decoration: InputDecoration(
                           hintText: translations.phoneNumberCode,
                         ),
                         style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                         keyboardType: TextInputType.number,
                         readOnly: true,
                       ),
                     ),
                     SizedBox(width: size.width * 0.01,),
                     Expanded(
                       child: FormBuilderTextField(
                         style: inputValueStyle,
                         textInputAction: TextInputAction.next,
                         name: "phoneNumber",
                         decoration: InputDecoration(
                           labelText: translations.phone_number,
                           hintText: translations.placeholder(translations.phone_number.toLowerCase()),
                         ),
                         keyboardType: TextInputType.number,
                         autofillHints: const <String>[AutofillHints.telephoneNumber],
                         validator: FormBuilderValidators.compose([
                           FormBuilderValidators.required(),
                           FormBuilderValidators.phoneNumber(),
                         ]),
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: space,),
                 SizedBox(
                   width: double.infinity,
                   child: BlocBuilder<UsersBloc, UsersState>(
                     builder: (context, state) {
                       return ElevatedButton(
                         onPressed: context.read<UsersBloc>().generalBloc.state.isLoading ? null : () {
                           if (_formKey.currentState!.saveAndValidate()) {
                            //TODO need to connect with the API...
                            log('updated personal information: ${_formKey.currentState!.value}');
                                 SuccessToast(
                                   title: AppLocalizations.of(context)!.suceess,
                                   description: translations.prop_updated(translations.personal_information),
                                   style: ToastificationStyle.flatColored,
                                   foregroundColor: Colors.white,
                                   backgroundColor: Colors.green.shade500,
                                   icon: const Icon(Icons.check, color: Colors.white,),
                                   autoCloseDuration: const Duration(seconds: 1),
                                   onAutoCompleted: (ToastificationItem item) => Navigator.of(context).pop()
                                 ).showToast(context);
                           }
                         },
                         child: context.watch<UsersBloc>().generalBloc.state.isLoading ? const CircularProgressIndicator.adaptive() : Text(translations.update_personal_information, style: theme.textTheme.labelMedium,),
                       );
                     },
                   ),
                 )
               ],
             )
           ),
        );
      },
    );
  }
}


enum ShippingAddressDialogType {
  ADD,
  UPDATE
}

class ShippingAddressDialog extends AlertDialogs {
  
    final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
    final Map<String, dynamic>? initialData;
    final ShippingAddressDialogType type;
  
    ShippingAddressDialog({this.initialData,required this.type,});
  
    @override
    Future<void> showAlertDialog(BuildContext context, AppLocalizations translations, ThemeData theme,) async {
      final TextStyle inputValueStyle = theme.textTheme.bodyMedium!.copyWith(color: Colors.black);
      return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(type == ShippingAddressDialogType.ADD ? translations.add_shipping_address : translations.update_shipping_address, style: theme.textTheme.titleMedium,),
            content: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                initialValue: initialData ?? {},
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      style: inputValueStyle,
                      textInputAction: TextInputAction.next,
                      name: "full-name",
                      decoration: InputDecoration(
                        labelText: translations.full_name,
                        hintText: translations.placeholder(translations.full_name.toLowerCase()),    
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: space,),
                    FormBuilderTextField(
                      style: inputValueStyle,
                      textInputAction: TextInputAction.next,
                      name: "address",
                      decoration: InputDecoration(
                        labelText: translations.address,
                        hintText: translations.placeholder(translations.address.toLowerCase()),
                        
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: space,),
                    FormBuilderTextField(
                      style: inputValueStyle,
                      textInputAction: TextInputAction.next,
                      name: "city",
                      decoration: InputDecoration(
                        labelText: translations.city,
                        hintText: translations.placeholder(translations.city.toLowerCase()),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: space,),
                    FormBuilderTextField(
                      style: inputValueStyle,
                      textInputAction: TextInputAction.next,
                      name: "zipCode",
                      decoration: InputDecoration(
                        labelText: translations.zip_code,
                        hintText: translations.placeholder(translations.zip_code.toLowerCase()),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    )
                  ],
                )
              ),
            ),
            actionsPadding: theme.dialogTheme.actionsPadding,
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>Navigator.of(context).pop(),
                child: Text(translations.cancel, style: theme.textTheme.labelMedium,),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    //TODO need to connect with the API...
                    log('updated shipping address: ${_formKey.currentState!.value}');
                    Navigator.of(context).pop();
                  }
                },
                child: Text(type == ShippingAddressDialogType.ADD ? translations.add : translations.update, style: theme.textTheme.labelMedium,),
              ),
            ],
          );
        }
      );
    }
            
}


class DeleteCartProductDialog extends AlertDialogs {
  
  final Product product;
  
  DeleteCartProductDialog({required this.product});
  
  @override
  Future<bool?> showAlertDialog(BuildContext context, AppLocalizations translations, ThemeData theme,) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete ${product.name}?'),
          content: Text('Are you sure you want to delete ${product.name} from the cart?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(translations.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(translations.delete),
            ),
          ],
        );
      },
    );
  }
          
}
