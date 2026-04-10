import 'package:equatable/equatable.dart';

import 'package:nexus/shared/models/user_model.dart';

class ConversationModel extends Equatable {
  const ConversationModel({
    required this.id,
    required this.participant,
    required this.lastMessage,
    required this.updatedAt,
    required this.unreadCount,
  });

  final String id;
  final UserModel participant;
  final String lastMessage;
  final DateTime updatedAt;
  final int unreadCount;

  @override
  List<Object?> get props => <Object?>[
        id,
        participant,
        lastMessage,
        updatedAt,
        unreadCount,
      ];
}
