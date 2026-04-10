import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.university,
    required this.year,
    required this.avatarUrl,
    required this.skills,
    required this.reputationScore,
    required this.reviewCount,
    required this.profileCompletionPercent,
  });

  final String id;
  final String name;
  final String email;
  final String university;
  final String year;
  final String avatarUrl;
  final List<String> skills;
  final double reputationScore;
  final int reviewCount;
  final int profileCompletionPercent;

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? university,
    String? year,
    String? avatarUrl,
    List<String>? skills,
    double? reputationScore,
    int? reviewCount,
    int? profileCompletionPercent,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      university: university ?? this.university,
      year: year ?? this.year,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      skills: skills ?? this.skills,
      reputationScore: reputationScore ?? this.reputationScore,
      reviewCount: reviewCount ?? this.reviewCount,
      profileCompletionPercent:
          profileCompletionPercent ?? this.profileCompletionPercent,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'university': university,
      'year': year,
      'avatarUrl': avatarUrl,
      'skills': skills,
      'reputationScore': reputationScore,
      'reviewCount': reviewCount,
      'profileCompletionPercent': profileCompletionPercent,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      university: json['university'] as String,
      year: json['year'] as String,
      avatarUrl: json['avatarUrl'] as String? ?? '',
      skills: List<String>.from(json['skills'] as List<dynamic>? ?? <String>[]),
      reputationScore: (json['reputationScore'] as num?)?.toDouble() ?? 0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      profileCompletionPercent: json['profileCompletionPercent'] as int? ?? 0,
    );
  }

  String get initials {
    final List<String> parts = name.trim().split(RegExp(r'\s+'));
    final String first =
        parts.isNotEmpty && parts.first.isNotEmpty ? parts.first[0] : '';
    final String last =
        parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        email,
        university,
        year,
        avatarUrl,
        skills,
        reputationScore,
        reviewCount,
        profileCompletionPercent,
      ];
}
