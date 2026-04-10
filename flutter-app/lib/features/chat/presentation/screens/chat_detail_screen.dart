import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexus/core/di/injection.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/features/chat/presentation/cubit/chat_cubit.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({required this.conversationId, super.key});

  final String conversationId;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (_) =>
          getIt<ChatCubit>()..loadConversation(widget.conversationId),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (BuildContext context, ChatState state) {
                  if (state is! ChatDetailLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final message = state.messages.reversed.toList()[index];
                      return Align(
                        alignment: message.isMine
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: message.isMine
                                ? NexusColors.yellow
                                : NexusColors.graphite,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            message.body,
                            style: TextStyle(
                              color: message.isMine
                                  ? NexusColors.black
                                  : NexusColors.offWhite,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: () async {
                      await context.read<ChatCubit>().sendMessage(
                            widget.conversationId,
                            _controller.text,
                          );
                      _controller.clear();
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
