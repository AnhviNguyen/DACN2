import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/learning_providers.dart';

class LearningContentAiChat extends ConsumerStatefulWidget {
  const LearningContentAiChat({super.key});

  @override
  ConsumerState<LearningContentAiChat> createState() => _LearningContentAiChatState();
}

class _LearningContentAiChatState extends ConsumerState<LearningContentAiChat> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    final chatMessages = ref.read(aiChatMessagesProvider);
    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: message,
      isUser: true,
      timestamp: DateTime.now(),
    );

    ref.read(aiChatMessagesProvider.notifier).addMessage(newMessage);
    _messageController.clear();

    // TODO: Call AI API and add response
    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      final aiResponse = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: 'Tôi hiểu bạn muốn luyện phát âm. Hãy thử phát âm từ "안녕하세요" theo cách sau: an-nyeong-ha-se-yo',
        isUser: false,
        timestamp: DateTime.now(),
      );
      ref.read(aiChatMessagesProvider.notifier).addMessage(aiResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final messages = ref.watch(aiChatMessagesProvider);
    final isTyping = ref.watch(isAiTypingProvider);

    // Initialize with welcome message if empty
    if (messages.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final welcomeMessage = ChatMessage(
          id: 'welcome',
          content: 'Xin chào! Tôi có thể giúp gì cho bạn về bài học hôm nay?',
          isUser: false,
          timestamp: DateTime.now(),
        );
        ref.read(aiChatMessagesProvider.notifier).setMessages([welcomeMessage]);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chat với AI',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        // Chat messages
        Container(
          height: 256,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            itemCount: messages.length + (isTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < messages.length) {
                return _buildMessage(context, theme, colorScheme, messages[index]);
              } else {
                return _buildTypingIndicator(context, theme);
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        // Input area
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Nhập tin nhắn...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colorScheme.primary, width: 2),
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.mic),
              onPressed: () {
                // TODO: Voice input
              },
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _sendMessage,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: const Text('Gửi'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessage(BuildContext context, ThemeData theme, ColorScheme colorScheme, ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser) ...[
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.psychology, size: 16, color: Colors.black),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: message.isUser ? colorScheme.primary : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: message.isUser ? Colors.white : colorScheme.primary,
                  ),
                ),
                child: Text(
                  message.content,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: message.isUser ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
            ),
            if (message.isUser) ...[
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, size: 16, color: Colors.black),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(BuildContext context, ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 8),
            Text(
              'AI đang trả lời...',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

