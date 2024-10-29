import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:daily_gratitude_app/models/post.dart';
import 'package:daily_gratitude_app/models/quote.dart';
import 'package:daily_gratitude_app/services/api_service.dart';

class JournalService extends ChangeNotifier {
  Quote _quote = Quote(text: "", author: "");
  final List<Post> _posts = [];
  final Map<String, dynamic> _sessionStorage = {};

  List<Post> get posts => _posts;
  Quote get quote => _quote;

  Future<void> addPost(Post post) async {
    _posts.add(post);
    await _saveChanges();
    notifyListeners();
  }

  Future<void> getQuote() async {
    _quote = await ApiService.instance.getQuote();
    notifyListeners();
  }

  Future<void> _saveChanges() async {
    try {
      List<String> postStrings =
          _posts.map((post) => jsonEncode(post.toJson())).toList();
      _sessionStorage['journal_posts'] = postStrings;
    } catch (e) {
      print("Error saving posts: $e");
    }
  }

  Future<void> loadPosts() async {
    try {
      List<String> postStrings = _sessionStorage['journal_posts'] ?? <String>[];

      _posts.clear();
      _posts.addAll(
        postStrings.map(
          (postString) => Post.fromJson(jsonDecode(postString)),
        ),
      );
      notifyListeners();
    } catch (e) {
      print("Error loading posts: $e");
    }
  }
}
