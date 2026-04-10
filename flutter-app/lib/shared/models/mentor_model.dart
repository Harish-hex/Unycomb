import 'package:equatable/equatable.dart';

import 'package:nexus/shared/models/user_model.dart';

class MentorModel extends Equatable {
  const MentorModel({
    required this.user,
    required this.expertise,
    required this.isAvailable,
  });

  final UserModel user;
  final List<String> expertise;
  final bool isAvailable;

  @override
  List<Object?> get props => <Object?>[user, expertise, isAvailable];
}
