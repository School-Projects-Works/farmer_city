import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:image_picker/image_picker.dart';

class CommunityServices{
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // save post images to firebase storage

  static Future<List<String>> savePostImages(List<XFile> images,String postId) async {
   try {
     List<String> imageUrls = [];
     for (var image in images) {
      var data = await image.readAsBytes();
       var ref = storage.ref().child('post_images').child('$postId/${DateTime.now().millisecondsSinceEpoch}.jpg');
       await ref.putData(data,SettableMetadata(contentType: 'image/jpeg'));
       var imageUrl = await ref.getDownloadURL();
       imageUrls.add(imageUrl);
     }
     return imageUrls;
   } catch (e) {
     return [];
   }
  }

  // save post to firestore
  static Future<void> savePost(PostModel data,List<XFile> images) async {
    try {
      if(images.isNotEmpty){
        data.images = await savePostImages(images, data.id!);
      }
      await firestore.collection('posts').doc(data.id).set(data.toMap());
    } catch (e) {
      return;
    }
  }

  // get all posts from firestore snapshot
  static Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return firestore.collection('posts').snapshots();
  }

  // get post by id
  static Future<PostModel?> getPostById(String id) async {
    try {
      var snapshot = await firestore.collection('posts').doc(id).get();
      if(snapshot.exists){
        return PostModel.fromMap(snapshot.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // update post
  static Future<void> updatePost(PostModel data,List<XFile> images) async {
    try {
      if(images.isNotEmpty){
        data.images = await savePostImages(images, data.id!);
      }
      await firestore.collection('posts').doc(data.id).update(data.toMap());
    } catch (e) {
      return;
    }
  }

}