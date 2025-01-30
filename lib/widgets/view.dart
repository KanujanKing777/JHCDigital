import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  final String imageUrl;

  // Constructor to accept the image URL as a parameter
  ImageFromUrl({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(imageUrl, fit: BoxFit.fitWidth,),
      ),
    );
  }
}
