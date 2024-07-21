import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/common/base_response.dart';

const String _FAVORITE_BOOKS = "_FAVORITE_BOOKS";

class LocalDataSource {
  FlutterSecureStorage? secureStorage;

  LocalDataSource({this.secureStorage});

  Future<bool> storeFavoriteBooks(List<Book> books) async {
    try {

      List<Map<String, dynamic>> temp = [];

      for (var element in books) {
        temp.add(element.toJson());
      }

      final String data = jsonEncode(books);
      await secureStorage!.write(key: _FAVORITE_BOOKS, value: data);
      return true;
    } on Exception {
      rethrow;
    }
  }

  Future<List<Book>> getFavouriteBooks() async {
    try {
      final result = await secureStorage!.read(key: _FAVORITE_BOOKS);
      if (result == null) {
        return [];
      } else {
        List<dynamic> data = jsonDecode(result);
        List<Book> temp = [];
        data.forEach((element) {
          temp.add(Book.fromJson(element));
        });
        return temp;
      }
    } on Exception {
      rethrow;
    }
  }
}
