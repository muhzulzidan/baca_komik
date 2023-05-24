import 'package:flutter/material.dart';

// import 'package:your_app/models/comic.dart'; // Import the Comic model
// import 'package:your_app/services/comic_service.dart';

import '../http/ComicDao.dart';
import 'ComicDetailScreen.dart'; // Import the ComicService

class ComicListScreen extends StatefulWidget {
  final List<Comic> comics; // Add a parameter to receive the comics list

  ComicListScreen({required this.comics});

  @override
  _ComicListScreenState createState() => _ComicListScreenState();
}

class _ComicListScreenState extends State<ComicListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comic List'),
      ),
      body: widget.comics.isNotEmpty
          ? ListView.builder(
              itemCount: widget.comics.length,
              itemBuilder: (context, index) {
                Comic comic = widget.comics[index];
                return GestureDetector(
                  onTap: () {
                    // Handle comic selection and navigate to Comic Detail Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComicDetailScreen(comic: comic),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(comic.coverUrl),
                    title: Text(comic.title),
                    // subtitle: Text(comic.description),
                  ),
                );
              },
            )
          : Center(
              child:
                  CircularProgressIndicator(), // Show a loading indicator if comics are being fetched
            ),
    );
  }
}
