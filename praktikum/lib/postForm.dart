import 'package:flutter/material.dart';
import 'package:praktikum/models/posts.dart';
import 'package:praktikum/services/PostApi.dart';
import 'package:praktikum/navigationBar.dart';

// Form Post (Create / Update)
class PostForm extends StatefulWidget {
  final Post? post; // Null untuk create, ada untuk update

  const PostForm({super.key, this.post});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final PostApi postApi = PostApi();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    // Jika edit, isi dengan data lama
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  // Save or Update Post
  Future<void> _savePost() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);

      try {
        final post = Post(
          id: widget.post?.id ?? 0, // ID tidak dipakai untuk create
          title: _titleController.text,
          body: _bodyController.text,
        );

        print('Attempting to save post: ${post.toJson()}');

        if (widget.post == null) {
          // CREATE
          print('Creating new post...');
          await postApi.createPost(post);
          print('Post created successfully!');
        } else {
          // UPDATE
          print('Updating post with ID: ${post.id}');
          await postApi.updatePost(post);
          print('Post updated successfully!');
        }

        print('Navigating back to MainNavigator with Posts tab...');

        // Kembali ke halaman utama tetapi langsung ke tab Posts (index 2)
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainNavigator(initialIndex: 3),
          ),
          (Route<dynamic> route) => false,
        );

      } catch (e) {
        print('Error in savePost: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Add Post' : 'Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Body Field
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a body';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Save Button
              _isSaving
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _savePost,
                      child: Text(widget.post == null ? 'Create' : 'Update'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
