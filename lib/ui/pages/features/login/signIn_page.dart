import 'dart:developer';

import '../../pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final FocusNode _userFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final Color _cursorColor = AppTheme.palette[600]!;
  final double _space = 20;


  @override
  void initState() {
    super.initState();
    locator<Preferences>().saveLastVisitedPage('sign_in_page');
  }

  @override
  void dispose() {
    super.dispose();
    _userFocusNode.dispose();
    _passwordFocusNode.dispose();

  }

  @override
  Widget build(BuildContext context) {
  
    
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final TextStyle inputValueStyle = theme.textTheme.bodyMedium!.copyWith(color: Colors.black);
    final AppLocalizations translations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/logos/logo_ourshop_1.png', height: 150, width: 150,),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: translations.welcome_to, 
                  style: theme.textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: translations.ourshop, 
                      style: theme.textTheme.titleMedium?.copyWith(color: Colors.blue)
                    ),
                    TextSpan(
                      text: translations.e_commerce, 
                      style: theme.textTheme.titleMedium
                    ),
                    TextSpan(
                      text: translations.app, 
                      style: theme.textTheme.titleMedium?.copyWith(color: Colors.blue)
                    ),
                  ]
                )
              ),
              SizedBox(height: _space,),
              Text.rich(TextSpan(
                text: translations.slogan_1, 
                style: theme.textTheme.titleLarge,
                children: [
                  TextSpan(
                    text:translations.slogan_2, 
                    style: theme.textTheme.titleMedium,
                  ),
                ]
              )),
              const SizedBox(height: 10,),
              Text.rich(TextSpan(
                text: translations.sing_in_your_account, 
                style: theme.textTheme.titleSmall,
                children: [
                  TextSpan(
                    text: ' ${translations.to} ${translations.continue_}', 
                    style: theme.textTheme.titleSmall
                  )
                ]
              )),
              SizedBox(height: _space,),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                          autofocus: true,
                          focusNode: _userFocusNode,
                          style: inputValueStyle,
                          onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocusNode),
                          textInputAction: TextInputAction.next,
                          name: "username",
                          cursorColor: _cursorColor,
                          decoration: InputDecoration(
                            labelText: translations.username,
                            hintText: translations.placeholder(translations.username.toLowerCase()),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: _space,),
                        FormBuilderTextField(
                          focusNode: _passwordFocusNode,
                          style: inputValueStyle,
                          textInputAction: TextInputAction.done,
                          name: "password",
                          cursorColor: _cursorColor,
                          decoration: InputDecoration(
                            labelText: translations.password,
                            hintText: translations.placeholder(translations.password.toLowerCase()),
                            
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6),
                          ]),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: FormBuilderCheckbox(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide.none
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                name: "remember_me", 
                                title: Text(translations.remember_me, style: theme.textTheme.bodySmall,),
                              ),
                            ),
                            TextButton(
                              onPressed: (){},
                              child: Text(translations.forgot_password, style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.palette[700]),),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (){
                              if (_formKey.currentState!.saveAndValidate()) {
                                log('form:${_formKey.currentState!.value}');
                                context.read<UsersBloc>().loginUser(_formKey.currentState!.value).then((_)=> Navigator.pushNamed(context, '/home'));
                              }
                            },
                            child: Text(translations.sign_in_with(translations.email.toLowerCase()), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              backgroundColor: const WidgetStatePropertyAll(Colors.white)
                            ),
                            onPressed: (){},
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset('assets/icons/google.png', height: 20, width: 20,)
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(translations.sign_in_with(translations.google.toLowerCase()), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),)
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              backgroundColor: const WidgetStatePropertyAll(Colors.black)
                            ),
                            onPressed: (){},
                            child: Stack(
                              children: [
                                 const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.apple, color: Colors.white, size: 25,)
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(translations.sign_in_with(translations.apple.toLowerCase()), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),)
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(translations.dont_have_account, style: theme.textTheme.bodySmall,),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(context, '/sign-up'),
                              child: Text(translations.sign_up, 
                                style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        )
                        
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}