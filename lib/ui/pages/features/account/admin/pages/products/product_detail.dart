import '../../../../../pages.dart';

enum AdminProductMode{
  EDIT,
  NEW
}

class AdminProductDetail extends StatelessWidget {
  AdminProductDetail({super.key, required this.product});

  final FilteredProducts product;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Helpers.truncateText(product.name, 30)),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: (){

        }
      ),
      body: ProductForm(
        formKey: _formKey
      ),
    );
  }
}

class Option {
  final int value;
  final String text;

  Option({required this.value, required this.text});
}

class ProductForm extends StatelessWidget {
  ProductForm({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;
  final ValueNotifier<int> option = ValueNotifier<int>(0);
  final ValueNotifier<List<File>> selectedPhotos = ValueNotifier<List<File>>([]);
  final ValueNotifier<List<File>> selectedVideos = ValueNotifier<List<File>>([]);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final List<Option> options = [
      Option(value: 0, text: translations.unit_price('')),
      Option(value: 1, text: translations.price_range),
    ];
    Widget spacer = const SizedBox(height: 10.0);
    final ThemeData theme = Theme.of(context);
    final TextStyle style = theme.textTheme.bodyLarge!.copyWith(color: Colors.black);
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration:  InputDecoration(
                  labelText: translations.name
                ),
              ),
              spacer,
              Text(translations.general, style: style.copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600) ,),
              spacer,
              FormBuilderDropdown(
                name: 'category',
                decoration: InputDecoration(
                  labelText: translations.category
                ), 
                items: const [],
              ),
              spacer,
              FormBuilderDropdown(
                name: 'product_group',
                decoration: InputDecoration(
                  labelText: translations.product_group
                ), 
                items: const [],
              ),
              spacer,
              FormBuilderDropdown(
                name: 'product_type',
                decoration:  InputDecoration(
                  labelText: translations.product_type
                ), 
                items: const [],
              ),
              spacer,
              FormBuilderDropdown(
                name: 'measurement_unit',
                decoration:  InputDecoration(
                  labelText: translations.product_unit
                ), 
                items: const [],
              ),
              spacer,
              FormBuilderTextField(
                name: 'model_number',
                decoration:  InputDecoration(
                  labelText: translations.model_number
                ),
              ),
              spacer,
              FormBuilderTextField(
                name: 'brand_name',
                decoration:  InputDecoration(
                  labelText: translations.brand_name
                ),
              ),
              spacer,
              FormBuilderTextField(
                name: 'key_value',
                decoration:  InputDecoration(
                  labelText: translations.key_value
                ),
              ),
              spacer,
              SizedBox(
                height: size.height * 0.07,
                width: size.width,
                child: ValueListenableBuilder<int>(
                  valueListenable: option, 
                  builder: (BuildContext context, int value, Widget? child) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: size.width * 0.5,
                          child: RadioListTile<int>(
                            shape: const RoundedRectangleBorder(
                              side: BorderSide.none,
                            ),
                            title: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(options[index].text, style: style.copyWith(fontSize: 13) ,)
                            ),
                            value: options[index].value,
                            groupValue: value,
                            onChanged: (newValue) {
                              option.value = newValue!;
                            },
                          ),
                        );
                      },
                    );
                  },
                  
                ),
              ),
              spacer,
              ValueListenableBuilder(
                valueListenable: option, 
                builder: (context, value, child) {
                  switch (value) {
                    case 1:
                      return Column(
                        children: [
                          FormBuilderTextField(
                            name: "fbo_price_start",
                            decoration: InputDecoration(
                              labelText: translations.fbo_start_price
                            ),
                          ),
                          spacer,
                          FormBuilderTextField(
                            name: "fbo_price_end",
                            decoration: InputDecoration(
                              labelText: translations.fbo_end_price
                            ),
                          ),
                          spacer,
                        ],
                      );
                    default:
                      return Column(
                        children: [
                        FormBuilderTextField(
                          name: "unit_price",
                          decoration: InputDecoration(
                            labelText: translations.unit_price('')
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              spacer,
              FormBuilderTextField(
                name: "inventory",
                decoration: InputDecoration(
                  labelText: translations.inventory
                ),
              ),
              spacer,
              FormBuilderTextField(
                name: "package_length",
                decoration: InputDecoration(
                  labelText: translations.package_length
                ),
              ),
              spacer,
              FormBuilderTextField(
                name: "package_width",
                decoration: InputDecoration(
                  labelText: translations.package_width
                ),
              ),
              spacer,
              FormBuilderTextField(
                name: "package_height",
                decoration: InputDecoration(
                  labelText: translations.package_height
                ),
              ),
              spacer,
              FormBuilderTextField(
                name: "package_weight",
                decoration: InputDecoration(
                  labelText: translations.package_weight
                ),
              ),
              spacer,
              Text(translations.photos, style: style.copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600) ,),
              spacer,
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () async {
                   final List<File> selectedPhotosResp = await context.read<ProductsBloc>().chooseAdminProductPhotos();
                   selectedPhotos.value = selectedPhotosResp;
                  }, 
                  child: Text(translations.choose_photos, style: style.copyWith(color: Colors.white),)
                ),
              ),
              spacer,
              ValueListenableBuilder(
                valueListenable: selectedPhotos,
                builder: (context, value, child) {
                  return Container(
                    height: size.height * 0.3,
                    width: size.width,
                    color: Colors.grey.shade200,
                    child: 
                    value.isEmpty 
                    ? Center(child: Text(translations.no_photos_selected, style: style.copyWith(color: Colors.black),)) 
                    : GridView.builder(
                        itemCount: selectedPhotos.value.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              image: DecorationImage(
                                image: FileImage(selectedPhotos.value[index]),
                                fit: BoxFit.cover
                              )
                            ),
                          );
                        },
                      )
                  );
                },
              ),
              spacer,
              Text(translations.videos, style: style.copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600) ,),
              spacer,
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () async {
                   final List<File> selectedVideosRes = await context.read<ProductsBloc>().chooseAdminProductVideos();
                    selectedVideos.value = selectedVideosRes;
                  }, 
                  child: Text(translations.choose_videos, style: style.copyWith(color: Colors.white),)
                ),
              ),
              spacer,
              ValueListenableBuilder(
                valueListenable: selectedVideos,
                builder: (context, value, child) {
                  return Container(
                    height: size.height * 0.3,
                    width: size.width,
                    color: Colors.grey.shade200,
                    child: 
                      value.isEmpty 
                      ? Center(child: Text(translations.no_videos_selected, style: style.copyWith(color: Colors.black),))
                      : GridView.builder(
                        itemCount: selectedVideos.value.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemBuilder: (context, index) {
                          return _VideoThumbnailWidget(file: selectedVideos.value[index]);
                        },
                      )
                  );
                },
              ),
              SizedBox(height: size.height * 0.05,),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoThumbnailWidget extends StatefulWidget {
  final File file;

  const _VideoThumbnailWidget({required this.file});

  @override
  _VideoThumbnailWidgetState createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<_VideoThumbnailWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {}); // Actualiza el estado cuando el video esté listo
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
      ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
      : const Center(child: CircularProgressIndicator.adaptive());
  }
}