import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firmer_city/features/assistant/data/messages_model.dart';

class MessagesServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<MessagesModel>> getMessagesByChatId(String chatId) async {
    final snapshot = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .get();
    return snapshot.docs
        .map((doc) => MessagesModel.fromMap(doc.data()))
        .toList();
  }

  static Future<void> createMessages(MessagesModel messages) async {
    try {
      await _firestore
          .collection('chats')
          .doc(messages.chatId)
          .collection('messages')
          .doc(messages.id)
          .set(messages.toMap());
    } catch (e) {
      print(e);
    }
  }

  static Future<String> getMessagesId(String chatId) async {
    // check if doc exist
    if(chatId.isEmpty) return _firestore.collection('chats').doc().id;
    var doc = await _firestore.collection('chats').doc(chatId).get();
    if (doc.exists) {
      return _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages').doc()
          .id; 
    }
    return _firestore.collection('chats').doc().id;
  }
}
