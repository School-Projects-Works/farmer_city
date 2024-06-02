import 'dart:convert';
import 'package:faker/faker.dart';

class CommentModel {
  String id;
  String postId;
  String writerId;
  String writerName;
  String writerImage;
  String content;
  int createdAt;
  CommentModel({
    required this.id,
    required this.postId,
    required this.writerId,
    required this.writerName,
    required this.writerImage,
    required this.content,
    required this.createdAt,
  });

  CommentModel copyWith({
    String? id,
    String? postId,
    String? writerId,
    String? writerName,
    String? writerImage,
    String? content,
    int? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      writerId: writerId ?? this.writerId,
      writerName: writerName ?? this.writerName,
      writerImage: writerImage ?? this.writerImage,
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

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] ?? '',
      postId: map['postId'] ?? '',
      writerId: map['writerId'] ?? '',
      writerName: map['writerName'] ?? '',
      writerImage: map['writerImage'] ?? '',
      content: map['content'] ?? '',
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModel(id: $id, postId: $postId, writerId: $writerId, writerName: $writerName, writerImage: $writerImage, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
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

  static List<CommentModel> dummyComments(String postId) {
    final _faker = Faker();
    var count = _faker.randomGenerator.integer(70, min: 0);
    List<CommentModel> comments = [];
    for (var i = 0; i < count; i++) {
      comments.add(CommentModel(
        id: _faker.guid.guid(),
        postId: postId,
        writerId: _faker.guid.guid(),
        writerName: _faker.person.name(),
        writerImage: _faker.image
            .image(keywords: ['avatar', 'person', 'people', 'user']),
        content: _faker.lorem
            .sentences(_faker.randomGenerator.integer(20, min: 1))
            .join(' '),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ));
    }
    return comments;
  }
}
