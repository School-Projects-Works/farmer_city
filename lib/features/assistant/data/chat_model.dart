import 'dart:convert';
import 'package:flutter/widgets.dart';

class ChatModel {
  String? id;
  String? userId;
  int? createdAt;
  String? firstQuestion;
  ChatModel({
    this.id,
    this.userId,
    this.createdAt,
    this.firstQuestion,
  });


  ChatModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? userId,
    ValueGetter<int?>? createdAt,
    ValueGetter<String?>? firstQuestion,
  }) {
    return ChatModel(
      id: id != null ? id() : this.id,
      userId: userId != null ? userId() : this.userId,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      firstQuestion: firstQuestion != null ? firstQuestion() : this.firstQuestion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'createdAt': createdAt,
      'firstQuestion': firstQuestion,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      userId: map['userId'],
      createdAt: map['createdAt']?.toInt(),
      firstQuestion: map['firstQuestion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(id: $id, userId: $userId, createdAt: $createdAt, firstQuestion: $firstQuestion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChatModel &&
      other.id == id &&
      other.userId == userId &&
      other.createdAt == createdAt &&
      other.firstQuestion == firstQuestion;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      createdAt.hashCode ^
      firstQuestion.hashCode;
  }
}
