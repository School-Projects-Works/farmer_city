import 'dart:convert';
import 'package:flutter/widgets.dart';

class CommentDataModel {
  String id;
  String postId;
  String writerId;
  String writerName;
  String? writerImage;
  String content;
  int createdAt;
  CommentDataModel({
    required this.id,
    required this.postId,
    required this.writerId,
    required this.writerName,
    this.writerImage,
    required this.content,
    required this.createdAt,
  });

  CommentDataModel copyWith({
    String? id,
    String? postId,
    String? writerId,
    String? writerName,
    ValueGetter<String?>? writerImage,
    String? content,
    int? createdAt,
  }) {
    return CommentDataModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      writerId: writerId ?? this.writerId,
      writerName: writerName ?? this.writerName,
      writerImage: writerImage != null ? writerImage() : this.writerImage,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'writerId': writerId,
      'writerName': writerName,
      'writerImage': writerImage,
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory CommentDataModel.fromMap(Map<String, dynamic> map) {
    return CommentDataModel(
      id: map['id'] ?? '',
      postId: map['postId'] ?? '',
      writerId: map['writerId'] ?? '',
      writerName: map['writerName'] ?? '',
      writerImage: map['writerImage'],
      content: map['content'] ?? '',
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentDataModel.fromJson(String source) => CommentDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentDataModel(id: $id, postId: $postId, writerId: $writerId, writerName: $writerName, writerImage: $writerImage, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CommentDataModel &&
      other.id == id &&
      other.postId == postId &&
      other.writerId == writerId &&
      other.writerName == writerName &&
      other.writerImage == writerImage &&
      other.content == content &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      postId.hashCode ^
      writerId.hashCode ^
      writerName.hashCode ^
      writerImage.hashCode ^
      content.hashCode ^
      createdAt.hashCode;
  }
}
