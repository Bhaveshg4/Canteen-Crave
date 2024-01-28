import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Future<String?> imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = fetchImageUrl();
  }

  Future<String?> fetchImageUrl() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('menu')
          .doc('menuDocument')
          .get();
      return snapshot['imageUrl'];
    } catch (e) {
      print('Error fetching image URL: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Menu"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_cooption.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: FutureBuilder<String?>(
                  future: imageUrl,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return Center(
                        child: Text(
                          'Error loading image',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      );
                    } else {
                      return PhotoViewGallery.builder(
                        itemCount: 1,
                        builder: (context, index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: NetworkImage(snapshot.data!),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 2,
                          );
                        },
                        backgroundDecoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        pageController: PageController(),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
