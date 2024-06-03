
import 'package:firmer_city/features/comments/model/comment_data.dart';
import 'package:firmer_city/features/comments/services/comment_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentsStreamProvider = StreamProvider.autoDispose
    .family<List<CommentDataModel>, String>((ref, postId) async* {
  var data = CommentServices.getComments(postId);
  await for (var commentSnap in data) {
    // order by created at
    commentSnap.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    yield commentSnap;
  }
});
