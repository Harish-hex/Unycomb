import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.body,
    required this.isMine,
    required this.sentAt,
  });

  final String id;
  final String conversationId;
  final String body;
  final bool isMine;
  final DateTime sentAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        conversationId,
        body,
        isMine,
        sentAt,
      ];
}
