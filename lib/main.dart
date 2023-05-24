import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

import 'http/ComicDao.dart';
import 'screens/ComicListScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DatabaseHelper.database;

  final comicDao = ComicDao();
  final comicChapter = ComicService();
  List<Comic> comics = await comicDao.fetchAndStoreComics();
  List<Chapter> chapter = await comicChapter.fetchChapters(
    'asura',
    'solo-leveling',
  );
  comics.forEach(print);
  chapter.forEach(print);
  runApp(MyApp(comics: comics)); // Print each comic using its toStrin
}

class MyApp extends StatelessWidget {
  final List<Comic> comics;

  MyApp({required this.comics});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ComicListScreen(
          comics: comics), // Set ComicListScreen as the home screen
    );
  }
}
