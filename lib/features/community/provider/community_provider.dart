

import 'package:firmer_city/features/comments/services/comment_services.dart';
import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:firmer_city/features/community/provider/post_provider.dart';
import 'package:firmer_city/features/community/services/community_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postStream = StreamProvider<List<PostModel>>((ref) async* {
  var data = CommunityServices.getPosts();
  await for (var item in data) {
    var list = item.docs.map((e) => PostModel.fromMap(e.data())).toList();
    //order by created at
    list.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    ref.read(postProvider.notifier).setPosts(list);

    // // date dummy comments
    // for (var post in list) {
    //   var comments = CommentModel.dummyComments(post.id!);
    //   for (var comment in comments) {
    //     await CommentServices.addComment(comment);
    //   }
    // }
    yield list;
  }
});
