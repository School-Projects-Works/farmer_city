import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firmer_city/features/assistant/data/chat_model.dart';

class ChatServices{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> createChat(ChatModel chat) async {
    try {
      await _firestore.collection('chats').doc(chat.id).set(chat.toMap());
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateChat(ChatModel chat) async {
    try {
      await _firestore.collection('chats').doc(chat.id).update(chat.toMap());
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteChat(String chatId) async {
    try {
      await _firestore.collection('chats').doc(chatId).delete();
    } catch (e) {
      print(e);
    }
  }

  static Stream<List<ChatModel>> getChats(String userId) {
    return _firestore.collection('chats').where('userId',isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ChatModel.fromMap(doc.data())).toList();
    });
  }

  static Future<ChatModel?> getChatById(String chatId) async {
    final doc = await _firestore.collection('chats').doc(chatId).get();
    if(doc.exists) {
      return ChatModel.fromMap(doc.data()!);
    }else{
      return null;
    }
  }

  static String getChatId() {
    return _firestore.collection('chats').doc().id;
  }
}