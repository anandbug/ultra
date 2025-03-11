import 'package:flutter/material.dart';

class ImageLoaderWidget extends StatelessWidget {
  final bool addPadding;
  const ImageLoaderWidget({this.addPadding = true, super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: addPadding ? const EdgeInsets.all(12.0) : EdgeInsets.all(6.0),
    child: CircularProgressIndicator(strokeWidth: 2),
  );
}
