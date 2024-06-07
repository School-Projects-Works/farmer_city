import 'dart:typed_data';

import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/functions/navigation.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:firmer_city/features/community/provider/post_provider.dart';
import 'package:firmer_city/features/community/services/community_services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

final newCommunityProvider =
    StateNotifierProvider<NewCommunityProvider, PostModel>((ref) {
  return NewCommunityProvider();
});

class NewCommunityProvider extends StateNotifier<PostModel> {
  NewCommunityProvider() : super(PostModel());

  void setTitle(String? value) {
    state = state.copyWith(title: () => value);
  }

  void setContent(String? value) {
    state = state.copyWith(description: () => value);
  }

  void createPost(
      {required WidgetRef ref, required BuildContext context}) async {
    CustomDialog.showLoading(message: 'Creating post....');
    var user = ref.watch(userProvider);
    var images = ref.watch(postImagesProvider);
    var postId = CommunityServices.getId();
    if (images.isNotEmpty) {
      var urls = await CommunityServices.uploadImages(images, postId);
      state = state.copyWith(images: urls);
    }
    state = state.copyWith(
      id: () => postId,
      authorId: () => user.id,
      authorName: () => user.name,
      authorImage: () => user.profileImage,
      createdAt: () => DateTime.now().millisecondsSinceEpoch,
      authorUserType: () => user.userType,
      likes: [],
    );
    await CommunityServices.savePost(state);
    CustomDialog.dismiss();
    CustomDialog.showToast(message: 'Post created successfully');
    navigateToRoute(context: context, route: RouterInfo.communityRoute);
  }
}

final postImagesProvider =
    StateNotifierProvider<PostImages, List<Uint8List>>((ref) {
  return PostImages();
});

class PostImages extends StateNotifier<List<Uint8List>> {
  PostImages() : super([]);

  void removeImage(Uint8List image) {
    var images = state.where((item) => item != image);
    state = [...images];
  }

  void pickImages() async {
    if (state.length >= 5) {
      CustomDialog.showToast(message: 'Maximum 5 images allowed');
      return;
    }
    var images = await ImagePicker().pickMultiImage(
      limit: 5 - state.length,
    );
    if (images.isNotEmpty) {
      var list = <Uint8List>[];
      for (var image in images) {
        var bytes = await image.readAsBytes();
        list.add(bytes);
      }
      state = [...state, ...list];
    }
  }
}
