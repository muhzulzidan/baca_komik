import 'package:flutter/material.dart';
// import 'package:your_app/models/comic.dart'; // Import the Comic model

import '../http/ComicDao.dart';

class ComicDetailScreen extends StatelessWidget {
  final Comic comic;

  ComicDetailScreen({required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(comic.coverUrl),
            SizedBox(height: 20),
            // Text(comic.description), 
          ],
        ),
      ),
    );
  }
}
