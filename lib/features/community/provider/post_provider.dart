import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/features/auth/data/user_model.dart';
import 'package:firmer_city/features/comments/model/comment_data.dart';
import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:firmer_city/features/community/services/community_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../comments/services/comment_services.dart';

final postProvider =
    StateNotifierProvider<PostProvider, List<PostModel>>((ref) {
  return PostProvider();
});

class PostProvider extends StateNotifier<List<PostModel>> {
  PostProvider() : super([]);

  void setPosts(List<PostModel> posts) {
    state = posts;
  }

  void addPost(PostModel post) {
    state = [...state, post];
  }

  void deletePost(String postId) async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deleting post....');

    bool success = await CommunityServices.deletePost(postId);
    if (success) {
      var list = state.where((element) => element.id != postId).toList();
      state = list;
    }
    CustomDialog.dismiss();
    CustomDialog.showToast(
        message: success ? 'Post deleted' : 'Failed to delete post');
  }

  void addComment(
      {required String comment,
      required UserModel user,
      required PostModel post,
      required WidgetRef ref}) async {
    ref.read(sendingCommentProvider.notifier).state = true;
    var id = CommentServices.getCommentId();

    CommentDataModel commentData = CommentDataModel(
      content: comment,
      id: id,
      writerId: user.id!,
      writerName: user.name!,
      writerImage: user.profileImage,
      postId: post.id!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await CommentServices.addComment(commentData);
    ref.read(sendingCommentProvider.notifier).state = false;
  }

  void likePost(
      {required PostModel post,
      required UserModel user,
      required WidgetRef ref}) async {
    var likes = post.likes.toList();
    if (likes.contains(user.id)) {
      likes.remove(user.id);
    } else {
      likes.add(user.id!);
    }
    post = post.copyWith(likes: likes);

    await CommunityServices.updatePost(post);
    ref.invalidate(getPostProvider(post.id!));
  }
}

final filterProvider = StateProvider.autoDispose<String>((ref) => '');

final filteredPostProvider = Provider.autoDispose<List<PostModel>>((ref) {
  final posts = ref.watch(postProvider);
  final query = ref.watch(filterProvider);
  if (query.isEmpty) {
    return posts;
  }
  return posts
      .where((element) =>
          element.title!.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

final getPostProvider =
    FutureProvider.autoDispose.family<PostModel?, String>((ref, id) async {
  var post = await CommunityServices.getPostById(id);
  if (post != null) {
    return post;
  }
  return null;
});

final sendingCommentProvider = StateProvider<bool>((ref) => false);
