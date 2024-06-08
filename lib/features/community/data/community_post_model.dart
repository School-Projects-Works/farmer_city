import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PostModel {
  String? id;
  List<String> images;
  String? title;
  String? description;
  String? authorId;
  String? authorName;
  String? authorImage;
  String? authorUserType;
  List<String> likes;
  bool isDeleted;
  int? createdAt;
  PostModel({
    this.id,
    this.images = const [],
    this.title,
    this.description,
    this.authorId,
    this.authorName,
    this.authorImage,
    this.authorUserType,
    this.likes = const [],
     this.isDeleted=false,
    this.createdAt,
  });

  PostModel copyWith({
    ValueGetter<String?>? id,
    List<String>? images,
    ValueGetter<String?>? title,
    ValueGetter<String?>? description,
    ValueGetter<String?>? authorId,
    ValueGetter<String?>? authorName,
    ValueGetter<String?>? authorImage,
    ValueGetter<String?>? authorUserType,
    List<String>? likes,
    bool? isDeleted,
    ValueGetter<int?>? createdAt,
  }) {
    return PostModel(
      id: id != null ? id() : this.id,
      images: images ?? this.images,
      title: title != null ? title() : this.title,
      description: description != null ? description() : this.description,
      authorId: authorId != null ? authorId() : this.authorId,
      authorName: authorName != null ? authorName() : this.authorName,
      authorImage: authorImage != null ? authorImage() : this.authorImage,
      authorUserType: authorUserType != null ? authorUserType() : this.authorUserType,
      likes: likes ?? this.likes,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'images': images,
      'title': title,
      'description': description,
      'authorId': authorId,
      'authorName': authorName,
      'authorImage': authorImage,
      'authorUserType': authorUserType,
      'likes': likes,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      images: List<String>.from(map['images']),
      title: map['title'],
      description: map['description'],
      authorId: map['authorId'],
      authorName: map['authorName'],
      authorImage: map['authorImage'],
      authorUserType: map['authorUserType'],
      likes: List<String>.from(map['likes']),
      isDeleted: map['isDeleted'] ?? false,
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(id: $id, images: $images, title: $title, description: $description, authorId: $authorId, authorName: $authorName, authorImage: $authorImage, authorUserType: $authorUserType, likes: $likes, isDeleted: $isDeleted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PostModel &&
      other.id == id &&
      listEquals(other.images, images) &&
      other.title == title &&
      other.description == description &&
      other.authorId == authorId &&
      other.authorName == authorName &&
      other.authorImage == authorImage &&
      other.authorUserType == authorUserType &&
      listEquals(other.likes, likes) &&
      other.isDeleted == isDeleted &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      images.hashCode ^
      title.hashCode ^
      description.hashCode ^
      authorId.hashCode ^
      authorName.hashCode ^
      authorImage.hashCode ^
      authorUserType.hashCode ^
      likes.hashCode ^
      isDeleted.hashCode ^
      createdAt.hashCode;
  }

  static List<PostModel> dummy() {
    final _faker = Faker();

    return List.generate(15, (index) {
      //generate random id of string from uuid
      var count = _faker.randomGenerator.integer(100, min: 1);
      var likes = List.generate(count, (index) => _faker.guid.guid());

      return PostModel(
        id: _faker.guid.guid(),
        images: List.generate(
            5,
            (index) => _faker.image.image(height: 800, random: true, keywords: [
                  'Farm',
                  'Agriculture',
                  'Nature',
                  'Farming',
                  'Crops', 'Animals', 'Food'
                ])),
        title: _faker.lorem.sentences(2).join(' '),
        description: _faker.lorem.sentences(100).join(' '),
        authorId: _faker.guid.guid(),
        authorName: _faker.person.name(),
        authorImage: _faker.image.image(),
        authorUserType: _faker.lorem.word(),
        likes: likes,
       isDeleted: false,
      );
    });
  }
}
