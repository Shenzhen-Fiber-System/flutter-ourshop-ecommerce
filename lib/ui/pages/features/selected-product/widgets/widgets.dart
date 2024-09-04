import 'dart:developer';

import '../../../pages.dart';

enum SectionType {
  videos,
  text
}

class Section extends StatelessWidget {
  final String title;
  final String content;
  final ThemeData theme;
  final AppLocalizations translations;
  final SectionType type;
  final Product? product;

  const Section({
    super.key,
    required this.title,
    required this.content,
    required this.theme,
    required this.translations, 
    required this.type, 
    this.product,
  }) : assert(type != SectionType.videos || product != null, 'Product must be provided for video sections');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        const Divider(indent: 12, endIndent: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: const Color(0xff5d5f61),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        if (type == SectionType.text) 
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              content,
              style: theme.textTheme.titleMedium?.copyWith(
                color: const Color(0xff5d5f61),
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        else  VideoProductSection(product: product!, theme: theme),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class VideoProductSection extends StatelessWidget {
  const VideoProductSection({
    super.key,
    required this.product,
    required this.theme,
  });

  final Product product;
  final ThemeData theme;

  String getMainUrl (dynamic link) {

    if(link is String && link.isNotEmpty) {
      return '${dotenv.env['PRODUCT_URL']}$link';
    }
    return product.videos.isNotEmpty ? '${dotenv.env['PRODUCT_URL']}${product.videos.first.url}' :  'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Video(url: getMainUrl(product.mainVideoUrl), height: 250, width: double.infinity),
          // else Container(
          //   height: 250,
          //   width: double.infinity,
          //   color: Colors.grey,
          //   child: Center(child: Text('Main video', style: widget.theme.textTheme.labelMedium?.copyWith(color: Colors.black),)),    
          // ),
          const SizedBox(height: 10.0),
          ListVideos(videos: product.videos),
        ],
      ),
    );
  }
}

class ListVideos extends StatefulWidget {
  const ListVideos({
    super.key,
    required this.videos,
  });

  final List<Photo> videos;

  @override
  State<ListVideos> createState() => _ListVideosState();
}

class _ListVideosState extends State<ListVideos> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.videos.length,
        itemBuilder: (BuildContext context, int index) {
          final Photo videos = widget.videos[index];
          log('url: ${videos.url}');
          return Video(url: '${dotenv.env['PRODUCT_URL']}${videos.url}', height: 150, width: double.infinity);
        },
      ),
    );
  }
}

class Video extends StatefulWidget {
  const Video({
    super.key,
    required this.url, required this.height, required this.width,
  });

  final double height;
  final double width;
  final String url;

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {

  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true,),
      ),
      autoPlay: false
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.25,
      width: size.width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: const FlickVideoWithControls(
            controls: FlickPortraitControls(),
          ),
        ),
      ),
    );
  }
}