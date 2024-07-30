import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comment.dart';

class ApiService {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/comments';
  static const int maxRetries = 3;

  Future<List<Comment>> fetchComments() async {
    int retries = 0;
    while (retries < maxRetries) {
      try {
        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          Iterable jsonResponse = json.decode(response.body);
          return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
        } else {
          throw Exception('Failed to load comments');
        }
      } catch (e) {
        retries++;
        if (retries >= maxRetries) {
          throw Exception('Failed to load comments after $maxRetries attempts: $e');
        }
      }
    }
    throw Exception('Unexpected error');
  }
}
