import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';

class PostModel {
  String? id;
  List<String> images;
  String? title;
  String? description;
  String? authorId;
  String? authorName;
  String? authorImage;
  String? authorUserType;
  int? likes;
  int? createdAt;
  PostModel({
    this.id,
    this.images= const [],
    this.title,
    this.description,
    this.authorId,
    this.authorName,
    this.authorImage,
    this.authorUserType,
    this.likes,
    this.createdAt,
  });

  PostModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<List<String>?>? images,
    ValueGetter<String?>? title,
    ValueGetter<String?>? description,
    ValueGetter<String?>? authorId,
    ValueGetter<String?>? authorName,
    ValueGetter<String?>? authorImage,
    ValueGetter<String?>? authorUserType,
    ValueGetter<int?>? likes,
    ValueGetter<int?>? createdAt,
  }) {
    return PostModel(
      id: id != null ? id() : this.id,
      images:  this.images,
      title: title != null ? title() : this.title,
      description: description != null ? description() : this.description,
      authorId: authorId != null ? authorId() : this.authorId,
      authorName: authorName != null ? authorName() : this.authorName,
      authorImage: authorImage != null ? authorImage() : this.authorImage,
      authorUserType:
          authorUserType != null ? authorUserType() : this.authorUserType,
      likes: likes != null ? likes() : this.likes,
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
      likes: map['likes']?.toInt(),
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(id: $id, images: $images, title: $title, description: $description, authorId: $authorId, authorName: $authorName, authorImage: $authorImage, authorUserType: $authorUserType, likes: $likes, createdAt: $createdAt)';
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
        other.likes == likes &&
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
        createdAt.hashCode;
  }

  static List<PostModel> dummy() {
    final _faker = Faker();
    return List.generate(
      10,
      (index) => PostModel(
        id: _faker.guid.guid(),
        images: List.generate(3, (index) => _faker.image.image(
          random: true,
          keywords: ['Farm', 'Agriculture', 'Nature', 'Farming', 'Crops']
        )),
        title: _faker.lorem.sentence(),
        description: _faker.lorem.sentences(5).join(' '),
        authorId: _faker.guid.guid(),
        authorName: _faker.person.name(),
        authorImage: _faker.image.image(),
        authorUserType: _faker.lorem.word(),
        likes: _faker.randomGenerator.integer(100),
        createdAt: _faker.date.dateTime().millisecondsSinceEpoch,
      ),
    );
  }
}
