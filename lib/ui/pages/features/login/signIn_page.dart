import '../../pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  late TextEditingController _userController;
  late TextEditingController _passwordController;

  final FocusNode _userFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final Color _cursorColor = AppTheme.palette[600]!;
  final double _space = 20;

  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(true);

  late bool rememberMe;


  @override
  void initState() {
    super.initState();
    context.read<RolesBloc>().add(const AddRolesEvent());
    context.read<CountryBloc>().add(const AddCountriesEvent());
    locator<Preferences>().saveLastVisitedPage('sign_in_page');
    _userController = TextEditingController(text: locator<Preferences>().preferences['username'] ?? '');
    _passwordController = TextEditingController(text: locator<Preferences>().preferences['password'] ?? '');
    rememberMe = bool.parse(locator<Preferences>().preferences['remember_me'] ?? 'false');
  }

  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _passwordController.dispose();

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
                      style: theme.textTheme.titleMedium?.copyWith(color: AppTheme.palette[800])
                    ),
                    TextSpan(
                      text: translations.e_commerce, 
                      style: theme.textTheme.titleMedium
                    ),
                    TextSpan(
                      text: translations.app, 
                      style: theme.textTheme.titleMedium?.copyWith(color: AppTheme.palette[800])
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
                child: BlocConsumer<UsersBloc, UsersState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        FormBuilderTextField(
                          readOnly: state.status == UserStatus.loading,
                          autofocus: rememberMe  ? false : true,
                          focusNode: _userFocusNode,
                          controller: _userController,
                          style: inputValueStyle,
                          onEditingComplete: () => rememberMe ? null : FocusScope.of(context).requestFocus(_passwordFocusNode),
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
                          onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        ),
                        SizedBox(height: _space,),
                        ValueListenableBuilder(
                          valueListenable: showPassword,
                          builder: (BuildContext context, value, _) {
                            return FormBuilderTextField(
                              readOnly: state.status == UserStatus.loading,
                              focusNode: _passwordFocusNode,
                              style: inputValueStyle,
                              controller: _passwordController,
                              textInputAction: TextInputAction.send,
                              onEditingComplete: () => _formKey.currentState!.save(),
                              onSubmitted: (_) => _doLogin(),
                              name: "password",
                              cursorColor: _cursorColor,
                              decoration: InputDecoration(
                                labelText: translations.password,
                                hintText: translations.placeholder(translations.password.toLowerCase()),
                                suffixIcon: IconButton(
                                  onPressed: state.status == UserStatus.loading ? null : () => showPassword.value = !showPassword.value,
                                  icon: Icon(showPassword.value ? Icons.visibility : Icons.visibility_off),
                                )
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(6),
                              ]),
                              obscureText: value,
                              onTapOutside: (event) => FocusScope.of(context).unfocus(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: IgnorePointer(
                                ignoring: state.status == UserStatus.loading,
                                child: FormBuilderCheckbox(
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide.none
                                  ),
                                  initialValue: rememberMe,
                                  onChanged: (value) {
                                    if(!value!){
                                      locator<Preferences>().removeData('remember_me');
                                      locator<Preferences>().removeData('username');
                                      locator<Preferences>().removeData('password');
                                    }
                                    locator<Preferences>().saveData('remember_me', value.toString());
                                  },
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
                            ),
                            // TextButton(
                            //   onPressed: state.status == UserStatus.loading ? null : (){},
                            //   child: Text(translations.forgot_password, style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.palette[700]),),
                            // )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state.status == UserStatus.loading ? null : ()  => _doLogin(),
                            child: state.status == UserStatus.loading ? const CircularProgressIndicator.adaptive() : Text(translations.sign_in_with(translations.email.toLowerCase()), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),),
                          ),
                        ),
                        // const SizedBox(height: 5,),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton(
                        //     style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        //       backgroundColor: const WidgetStatePropertyAll(Colors.white)
                        //     ),
                        //     onPressed: state.status == UserStatus.loading ? null : (){},
                        //     child: Stack(
                        //       children: [
                        //         Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Image.asset('assets/icons/google.png', height: 20, width: 20,)
                        //         ),
                        //         Align(
                        //           alignment: Alignment.center,
                        //           child: Text(translations.sign_in_with(translations.google.toLowerCase()), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),)
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 5,),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton(
                        //     style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        //       backgroundColor: const WidgetStatePropertyAll(Colors.black)
                        //     ),
                        //     onPressed: state.status == UserStatus.loading ? null : (){},
                        //     child: Stack(
                        //       children: [
                        //           const Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Icon(Icons.apple, color: Colors.white, size: 25,)
                        //         ),
                        //         Align(
                        //           alignment: Alignment.center,
                        //           child: Text(translations.sign_in_with(translations.apple.toLowerCase()), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),)
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(translations.dont_have_account, style: theme.textTheme.bodySmall,),
                            TextButton(
                              onPressed: state.status == UserStatus.loading ? null : () => context.push('/sign-up'),
                              child: Text(translations.sign_up, 
                                style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.palette[800], fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        )   
                      ],
                    );
                  }, listener: (BuildContext context, UsersState state) {
                    if(state.status == UserStatus.logged && state.loggedUser.userId.isNotEmpty) {
                      context.go('/home');
                    }
                  },
                )
              )
            ],
          ),
        ),
      )
    );
  }

  void _doLogin() {
    if (_formKey.currentState!.saveAndValidate()) {
      if (_formKey.currentState!.value['remember_me']) {
        locator<Preferences>().saveData('username', _formKey.currentState!.value['username']);
        locator<Preferences>().saveData('password', _formKey.currentState!.value['password']);
      }
      FocusScope.of(context).unfocus();
      context.read<UsersBloc>().add(Login(data : _formKey.currentState!.value));
    }
  }
}