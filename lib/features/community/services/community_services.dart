import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firmer_city/features/community/data/community_post_model.dart';

class CommunityServices {
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // save post images to firebase storage

  // save post to firestore
  static Future<void> savePost(PostModel data) async {
    try {
      await firestore.collection('posts').doc(data.id).set(data.toMap());
    } catch (e) {
      return;
    }
  }

  // get all posts from firestore snapshot
  static Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return firestore.collection('posts').where('isDeleted',isEqualTo: false).snapshots();
  }

  // get post by id
  static Future<PostModel?> getPostById(String id) async {
    try {
      var snapshot = await firestore.collection('posts').doc(id).get();
      if (snapshot.exists) {
        return PostModel.fromMap(snapshot.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // update post
  static Future<void> updatePost(PostModel data) async {
    try {
      await firestore.collection('posts').doc(data.id).update(data.toMap());
    } catch (e) {
      return;
    }
  }

  static Future<List<String>> uploadImages(
      List<Uint8List> images, String postId) async {
    try {
      List<String> urls = [];
      for (var image in images) {
        var ref = storage
            .ref('Post')
            .child(postId)
            .child('${images.indexOf(image)}.jpg');
        await ref.putData(image, SettableMetadata(contentType: 'image/jpeg'));
        var url = await ref.getDownloadURL();
        urls.add(url);
      }
      return urls;
    } catch (e) {
      return [];
    }
  }

  static String getId() {
    return firestore.collection('posts').doc().id;
  }

  static Future<bool> deletePost(String postId) async {
    try {
      // marke isDeleted to true
      await firestore
          .collection('posts')
          .doc(postId)
          .update({'isDeleted': true});
      return true;
    } catch (e) {
      return false;
    }
  }
}
