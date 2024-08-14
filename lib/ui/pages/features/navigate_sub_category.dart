

import 'package:flutter/material.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      height: size.height * 0.20,
      width: size.width,
      // child: ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   itemCount: category.subCategories?.length,
      //   itemBuilder: (context, index) {
      //     return CustomCard(
      //       height: size.height * 0.15, 
      //       width: size.width * 0.35,
      //       theme: theme,
      //       translations: translations,
      //       children: [
      //         Text(category.subCategories![index].name, style: theme.textTheme.labelSmall,),
      //       ],
      //       onTap: () => onTap != null ? onTap!() : null,
      //     );
      //   },
      // ),
    );
  }
}