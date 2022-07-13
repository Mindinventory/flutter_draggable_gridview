import 'package:flutter/material.dart';

import '../constants/dimens.dart';

class GridItem extends StatelessWidget {
  const GridItem({required this.image, Key? key}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.padding_small,
        vertical: Dimens.padding_small,
      ),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
