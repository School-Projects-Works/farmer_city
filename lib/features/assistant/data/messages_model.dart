import 'dart:convert';

import 'package:flutter/widgets.dart';

class MessagesModel {
  String? id;
  String sender;
  String questionType;
  String question;
  String response;
  String chatId;
  int createdAt;
  MessagesModel({
    this.id,
    required this.sender,
    required this.questionType,
    required this.question,
    required this.response,
    required this.chatId,
    required this.createdAt,
  });

  MessagesModel copyWith({
    ValueGetter<String?>? id,
    String? sender,
    String? questionType,
    String? question,
    String? response,
    String? chatId,
    int? createdAt,
  }) {
    return MessagesModel(
      id: id != null ? id() : this.id,
      sender: sender ?? this.sender,
      questionType: questionType ?? this.questionType,
      question: question ?? this.question,
      response: response ?? this.response,
      chatId: chatId ?? this.chatId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'questionType': questionType,
      'question': question,
      'response': response,
      'chatId': chatId,
      'createdAt': createdAt,
    };
  }

  factory MessagesModel.fromMap(Map<String, dynamic> map) {
    return MessagesModel(
      id: map['id'],
      sender: map['sender'] ?? '',
      questionType: map['questionType'] ?? '',
      question: map['question'] ?? '',
      response: map['response'] ?? '',
      chatId: map['chatId'] ?? '',
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagesModel.fromJson(String source) => MessagesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessagesModel(id: $id, sender: $sender, questionType: $questionType, question: $question, response: $response, chatId: $chatId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MessagesModel &&
      other.id == id &&
      other.sender == sender &&
      other.questionType == questionType &&
      other.question == question &&
      other.response == response &&
      other.chatId == chatId &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      sender.hashCode ^
      questionType.hashCode ^
      question.hashCode ^
      response.hashCode ^
      chatId.hashCode ^
      createdAt.hashCode;
  }
}
