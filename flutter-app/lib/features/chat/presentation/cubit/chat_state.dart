part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => <Object?>[];
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatListLoaded extends ChatState {
  const ChatListLoaded(this.conversations);

  final List<ConversationModel> conversations;

  @override
  List<Object?> get props => <Object?>[conversations];
}

class ChatDetailLoaded extends ChatState {
  const ChatDetailLoaded({required this.conversation, required this.messages});

  final ConversationModel conversation;
  final List<MessageModel> messages;

  @override
  List<Object?> get props => <Object?>[conversation, messages];
}
