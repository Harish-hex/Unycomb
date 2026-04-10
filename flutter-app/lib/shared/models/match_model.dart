import 'package:equatable/equatable.dart';

import 'package:nexus/shared/models/user_model.dart';

enum MatchStatus { suggested, requested, connected }

class MatchModel extends Equatable {
  const MatchModel({
    required this.id,
    required this.user,
    required this.bio,
    required this.matchStatus,
  });

  final String id;
  final UserModel user;
  final String bio;
  final MatchStatus matchStatus;

  MatchModel copyWith({
    String? id,
    UserModel? user,
    String? bio,
    MatchStatus? matchStatus,
  }) {
    return MatchModel(
      id: id ?? this.id,
      user: user ?? this.user,
      bio: bio ?? this.bio,
      matchStatus: matchStatus ?? this.matchStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user': user.toJson(),
      'bio': bio,
      'matchStatus': matchStatus.name,
    };
  }

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      bio: json['bio'] as String,
      matchStatus: MatchStatus.values.firstWhere(
        (MatchStatus value) => value.name == json['matchStatus'],
        orElse: () => MatchStatus.suggested,
      ),
    );
  }

  @override
  List<Object?> get props => <Object?>[id, user, bio, matchStatus];
}
