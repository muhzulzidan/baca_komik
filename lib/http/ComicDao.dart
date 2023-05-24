import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class Comic {
  final String provider;
  final String title;
  final String coverUrl;

  Comic({required this.provider, required this.title, required this.coverUrl});

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      provider: json['provider'],
      title: json['title'],
      coverUrl: json['coverURL'],
    );
  }

  @override
  String toString() {
    return 'Comic{provider: $provider, title: $title, coverUrl: $coverUrl}';
  }
}

class Chapter {
  final String providerWebtoon;
  final String slug;
  final String fullTitle;
  final String shortTitle;
  final int chapterNum;
  final String sourceURL;
  final String shortURL;
  final Map<String, dynamic> chapterNav;
  final List<String> contentURL;
  final DateTime createdAt;
  final DateTime updatedAt;

  Chapter({
    required this.providerWebtoon,
    required this.slug,
    required this.fullTitle,
    required this.shortTitle,
    required this.chapterNum,
    required this.sourceURL,
    required this.shortURL,
    required this.chapterNav,
    required this.contentURL,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      providerWebtoon: json['provider_webtoon'],
      slug: json['slug'],
      fullTitle: json['fullTitle'],
      shortTitle: json['shortTitle'],
      chapterNum: json['chapterNum'],
      sourceURL: json['sourceURL'],
      shortURL: json['shortURL'],
      chapterNav: json['chapterNav'],
      contentURL: List<String>.from(json['contentURL']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'Chapter{providerWebtoon: $providerWebtoon, slug: $slug, fullTitle: $fullTitle, shortTitle: $shortTitle, chapterNum: $chapterNum, sourceURL: $sourceURL, shortURL: $shortURL, chapterNav: $chapterNav, contentURL: $contentURL, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}



class ComicService {
  static const String apiKey =
      '55b6cfca16msh6ec1249473be94bp13bc58jsnede68778dfd3';
  static const String host = 'manga-scrapper.p.rapidapi.com';

  Future<List<Chapter>> fetchChapters(String provider, String webtoon,
      {int page = 1, int limit = 10}) async {
    final Uri chaptersUri = Uri.parse(
        'https://$host/chapters?provider=$provider&webtoon=$webtoon&page=$page&limit=$limit');

    final response = await http.get(chaptersUri, headers: {
      'X-Rapidapi-Key': apiKey,
      'X-Rapidapi-Host': host,
    });

    if (response.statusCode == 200) {
      List<dynamic> chapterData = jsonDecode(response.body);

      List<Chapter> chapters = chapterData
          .map((json) => Chapter.fromJson(json))
          .toList(); // Convert JSON data to Chapter objects
      print(chapters);
      return chapters;
    } else {
      throw Exception('Failed to fetch chapter data from the API.');
    }
  }
}

class ComicDao {
  static const String apiKey =
      '55b6cfca16msh6ec1249473be94bp13bc58jsnede68778dfd3';
  static const String host = 'manga-scrapper.p.rapidapi.com';

  Future<List<Comic>> fetchAndStoreComics() async {
    final Uri providersUri = Uri.parse('https://$host/providers');
    final Uri webtoonsUri =
        Uri.parse('https://$host/webtoons?provider=surya&page=1&limit=10');

    final responseProviders = await http.get(providersUri, headers: {
      'X-Rapidapi-Key': apiKey,
      'X-Rapidapi-Host': host,
    });

    final responseWebtoons = await http.get(webtoonsUri, headers: {
      'X-Rapidapi-Key': apiKey,
      'X-Rapidapi-Host': host,
    });

    if (responseProviders.statusCode == 200 &&
        responseWebtoons.statusCode == 200) {
      List<dynamic> providerData = jsonDecode(responseProviders.body);
      List<dynamic> webtoonData = jsonDecode(responseWebtoons.body);

      List<Comic> comics =
          webtoonData.map((json) => Comic.fromJson(json)).toList();
      // print(comics);
      return comics;
    } else {
      throw Exception('Failed to fetch data from the API.');
    }
  }
}
