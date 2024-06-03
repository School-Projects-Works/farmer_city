import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firmer_city/features/comments/model/comment_data.dart';




class CommentServices{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addComment(CommentDataModel comment) async {
    try {
      await _firestore.collection('comments').doc(comment.id).set(comment.toMap());
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteComment(String id) async {
    try {
      await _firestore.collection('comments').doc(id).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> updateComment(CommentDataModel comment) async {
    try {
      await _firestore.collection('comments').doc(comment.id).update(comment.toMap());
    } catch (e) {
     print(e);
    }
  }

  static Stream<List<CommentDataModel>> getComments(String postId) {
    return _firestore.collection('comments').where('postId', isEqualTo: postId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CommentDataModel.fromMap(doc.data())).toList();
    });
  }

  static String getCommentId() {
    return _firestore.collection('comments').doc().id;
  }


}