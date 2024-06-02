import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/comment_model.dart';



class CommentServices{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addComment(CommentModel comment) async {
    try {
      await _firestore.collection('comments').doc(comment.id).set(comment.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> deleteComment(String id) async {
    try {
      await _firestore.collection('comments').doc(id).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> updateComment(CommentModel comment) async {
    try {
      await _firestore.collection('comments').doc(comment.id).update(comment.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  static Stream<List<CommentModel>> getComments(String postId) {
    return _firestore.collection('comments').where('postId', isEqualTo: postId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CommentModel.fromMap(doc.data())).toList();
    });
  }


}