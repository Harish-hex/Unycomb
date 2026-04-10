import 'package:equatable/equatable.dart';

import 'package:nexus/shared/models/user_model.dart';

class ReviewModel extends Equatable {
  const ReviewModel({
    required this.id,
    required this.fromUser,
    required this.rating,
    required this.text,
    required this.createdAt,
  });

  final String id;
  final UserModel fromUser;
  final double rating;
  final String text;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'fromUser': fromUser.toJson(),
      'rating': rating,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      fromUser: UserModel.fromJson(json['fromUser'] as Map<String, dynamic>),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  List<Object?> get props => <Object?>[id, fromUser, rating, text, createdAt];
}
