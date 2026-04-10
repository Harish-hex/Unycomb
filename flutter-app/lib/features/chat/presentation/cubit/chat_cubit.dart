import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/shared/mock/mock_app_store.dart';
import 'package:nexus/shared/models/conversation_model.dart';
import 'package:nexus/shared/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required MockAppStore appStore})
      : _appStore = appStore,
        super(const ChatLoading());

  final MockAppStore _appStore;

  Future<void> loadConversations() async {
    emit(ChatListLoaded(_appStore.conversations));
  }

  Future<void> loadConversation(String conversationId) async {
    final ConversationModel conversation = _appStore.conversations.firstWhere(
      (ConversationModel item) => item.id == conversationId,
    );
    emit(
      ChatDetailLoaded(
        conversation: conversation,
        messages: _appStore.messagesFor(conversationId),
      ),
    );
  }

  Future<void> sendMessage(String conversationId, String text) async {
    if (text.trim().isEmpty) {
      return;
    }
    await _appStore.sendMessage(
      conversationId: conversationId,
      text: text.trim(),
    );
    await loadConversation(conversationId);
  }
}
