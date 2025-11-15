import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:praktikum/models/posts.dart';

class PostApi {
  static const String _baseUrl = 'https://api-post.banjarmasinkota.xyz/api/posts';

  // GET
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {'Authorization': 'Bearer API_CRYiIec4afpEMqoKuSAnmGJKb96xfDnn'},
    );

    print('Fetch Posts Response: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      List<dynamic> body;

      if (decoded is Map<String, dynamic>) {
        if (decoded.containsKey('data')) {
          body = decoded['data'];
        } else if (decoded.containsKey('posts')) {
          body = decoded['posts'];
        } else if (decoded.containsKey('results')) {
          body = decoded['results'];
        } else {
          throw Exception('Unknown response format: ${response.body}');
        }
      } else if (decoded is List) {
        body = decoded;
      } else {
        throw Exception('Invalid response format: ${response.body}');
      }

      return body.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts. Status: ${response.statusCode}');
    }
  }

  // POST
  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer API_CRYiIec4afpEMqoKuSAnmGJKb96xfDnn',
      },
      body: jsonEncode(post.toJson()),
    );

    print('Create Response: ${response.statusCode} => ${response.body}');

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decoded is Map<String, dynamic>) {
        if (decoded.containsKey('data')) {
          return Post.fromJson(decoded['data']);
        } else if (decoded.containsKey('post')) {
          return Post.fromJson(decoded['post']);
        } else {
          return Post.fromJson(decoded);
        }
      }
      throw Exception('Invalid response: ${response.body}');
    } else {
      throw Exception('Failed to create post: ${response.statusCode}');
    }
  }

  // PUT
  Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${post.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer API_CRYiIec4afpEMqoKuSAnmGJKb96xfDnn',
      },
      body: jsonEncode(post.toJson()),
    );

    print('Update Response: ${response.statusCode} - ${response.body}');

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decoded is Map<String, dynamic>) {
        if (decoded.containsKey('data')) {
          return Post.fromJson(decoded['data']);
        } else if (decoded.containsKey('post')) {
          return Post.fromJson(decoded['post']);
        } else {
          return Post.fromJson(decoded);
        }
      }
      throw Exception('Invalid response: ${response.body}');
    }

    throw Exception('Failed to update post: ${response.statusCode}');
  }

  // DELETE
  Future<void> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Authorization': 'Bearer API_CRYiIec4afpEMqoKuSAnmGJKb96xfDnn'},
    );

    print('Delete Response: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete post: ${response.statusCode}');
    }
  }
}
