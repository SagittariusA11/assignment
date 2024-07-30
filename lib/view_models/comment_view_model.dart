import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/comment.dart';
import '../services/api_services.dart';

class CommentsViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Comment> _comments = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchComments() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _comments = await _apiService.fetchComments();
    } catch (e) {
      _errorMessage = 'Failed to load comments';
      print('Error fetching comments: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
