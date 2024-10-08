

import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key, 
    required this.height, 
    required this.width, 
    required this.theme, 
    required this.translations, 
    required this.onTap, 
    this.urlImage, 
    this.children,
    this.child
  });


  final double height;
  final double width;
  final ThemeData theme;
  final AppLocalizations translations;
  final Function onTap;
  final String? urlImage;
  final List<Widget>? children;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                child: Image(
                  image: NetworkImage( urlImage ?? 'https://placehold.co/600x400'),
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.image_not_supported, size: 50.0, color: Colors.grey.shade500,),
                        Text(translations.no_image, style: theme.textTheme.labelMedium?.copyWith(color: Colors.grey.shade500)),
                      ],
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children ?? []
              ),
            ),
          ],
        ),
      ),
    );
  }
}