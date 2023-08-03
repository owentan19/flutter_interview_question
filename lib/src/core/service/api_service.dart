import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modals/comment.dart';
import '../modals/post.dart';

class ApiService {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<Post> getPost(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch post');
    }
  }

  Future<List<Comment>> getCommentsForPost(int postId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/comments?postId=$postId'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch comments for post');
    }
  }
}
