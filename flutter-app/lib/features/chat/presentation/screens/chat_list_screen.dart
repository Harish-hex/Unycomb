import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:nexus/core/components/nexus_avatar.dart';
import 'package:nexus/core/components/nexus_badge.dart';
import 'package:nexus/core/di/injection.dart';
import 'package:nexus/core/utils/formatters.dart';
import 'package:nexus/features/chat/presentation/cubit/chat_cubit.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (_) => getIt<ChatCubit>()..loadConversations(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (BuildContext context, ChatState state) {
            if (state is! ChatListLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.conversations.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                final item = state.conversations[index];
                return ListTile(
                  onTap: () => context.push('/chat/${item.id}'),
                  contentPadding: EdgeInsets.zero,
                  leading: NexusAvatar(user: item.participant),
                  title: Text(item.participant.name),
                  subtitle: Text(item.lastMessage, maxLines: 1),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(formatRelativeSection(item.updatedAt)),
                      if (item.unreadCount > 0) ...<Widget>[
                        const SizedBox(height: 6),
                        NexusBadge(value: '${item.unreadCount}'),
                      ],
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
