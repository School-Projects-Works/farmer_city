import 'package:firmer_city/features/comments/data/comment_model.dart';
import 'package:firmer_city/features/comments/services/comment_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentsStreamProvider = StreamProvider.autoDispose
    .family<List<CommentModel>, String>((ref, postId) async* {
  var data = CommentServices.getComments(postId);
  await for (var commentSnap in data) {
    yield commentSnap;
  }
});
