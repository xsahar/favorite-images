import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_viewer_screen.dart';

const Color appPurple = Color(0xFF625BEE);
const Color appBlue = Color(0xFF438FF8);
const Color appBackground = Color(0xFFF6F5FC);
const Color appText = Color(0xFF202B55);

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
 final List<File> _images = [];

  final _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
       _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          appPurple,
          appBlue,
        ],
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
  actions: [
    PopupMenuButton<ImageSource>(
      shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(16),
),
elevation: 8,
color: Colors.white,
      padding: const EdgeInsets.only(right: 12),
      onSelected: pickImage,
     itemBuilder: (context) => [
  const PopupMenuItem(
    value: ImageSource.camera,
    child: Row(
      children: [
        Icon(Icons.camera_alt_outlined, color: appPurple),
        SizedBox(width: 12),
        Text('Camera'),
      ],
    ),
  ),
  const PopupMenuItem(
    value: ImageSource.gallery,
    child: Row(
      children: [
        Icon(Icons.photo_library_outlined, color: appBlue),
        SizedBox(width: 12),
        Text('Gallery'),
      ],
    ),
  ),
],
      child: const Padding(
        padding: EdgeInsets.only(right: 12),
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      ),
    ),
  ],
),
    body: _images.isEmpty
    ? Center(
        child: Transform.translate(
        offset: const Offset(0, -35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
  ShaderMask(
  shaderCallback: (bounds) => const LinearGradient(
    colors: [appPurple, appBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ).createShader(bounds),
  child: const Icon(
    Icons.photo_library_outlined,
    size: 80,
    color: Colors.white,
  ),
),


// Main message
const Text(
  'Your gallery is empty',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: appText,
  ),
),

// Supporting message
const Text(
  'Tap + to add your favorite photos',
  style: TextStyle(
    fontSize: 14,
    color: Colors.black,
  ),
),
          ],
        ),
        ),
      )
      : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: 
        const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        ),
        itemCount: _images.length,
         itemBuilder: (context, index){
       return GestureDetector(
  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ImageViewerScreen(
        image: _images[index],
      ),
    ),
  );
},

child: Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.12),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Image.file(
      _images[index],
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
  ),
),
);
         } ,
         ),
    );
  }
}