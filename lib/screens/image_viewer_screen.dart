import 'dart:io';

import 'package:favorite_images/screens/gallery_screen.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final File image;

  const ImageViewerScreen({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [appPurple, appBlue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Favorite Images',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            fontFamily: 'Georgia',
          ),
        ),
      ),
      body: SizedBox.expand(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Center(
            child: Image.file(
              image,
              fit: BoxFit.contain,
              gaplessPlayback: true,
            ),
          ),
        ),
      ),
    );
  }
}