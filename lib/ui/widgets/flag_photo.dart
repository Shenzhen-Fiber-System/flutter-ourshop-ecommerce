
import '../pages/pages.dart';

class FlagPhoto extends StatelessWidget {
  const FlagPhoto({
    super.key, 
    required this.country,
  });

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '${dotenv.env['FLAG_URL']}${country.flagUrl}', 
      width: 30, 
      height: 30,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.no_photography);
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return wasSynchronouslyLoaded 
        ? child 
        : AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
          child: child,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}