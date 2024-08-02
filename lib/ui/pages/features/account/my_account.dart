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
      duration: const Duration(milliseconds: 800),
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
    return Container(
      color: Colors.grey,
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
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.line_style_rounded),
                ),
              ),
            ),
            actions: [
              const Icon(Icons.square),
              const Text('MXN'),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    height: 60.0,
                    color: Colors.grey.shade50,
                    child: const _AvatarButton(),
                  );
                }
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 1000,
            ),
          ),
        ],
      )
    );
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