import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPost extends ConsumerStatefulWidget {
  const EditPost({super.key, required this.postId});
  final String postId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPostState();
}

class _EditPostState extends ConsumerState<EditPost> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}