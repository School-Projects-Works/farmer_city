import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:firmer_city/features/community/services/community_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void deletePost(String s) {}
}

final filterProvider = StateProvider<String>((ref) => '');

final filteredPostProvider = Provider.autoDispose<List<PostModel>>((ref) {
  final posts = ref.watch(postProvider);
  final query = ref.watch(filterProvider);
  if (query.isEmpty) {
    return posts;
  }
  return posts.where((element) => element.title!.contains(query)).toList();
});

final getPostProvider =
    FutureProvider.autoDispose.family<PostModel?, String>((ref, id) async {
  var post = await CommunityServices.getPostById(id);
  if (post != null) {
    return post;
  }
  return null;
});
