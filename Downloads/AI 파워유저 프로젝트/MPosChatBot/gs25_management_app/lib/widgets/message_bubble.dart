import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import '../models/message.dart';
import '../utils/colors.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final timeString = DateFormat('HH:mm').format(message.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: isUser 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            // Bot avatar
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.smart_toy,
                color: AppColors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          // Message bubble
          Flexible(
            child: Column(
              crossAxisAlignment: isUser 
                  ? CrossAxisAlignment.end 
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isUser 
                        ? AppColors.chatUserBubble 
                        : AppColors.chatBotBubble,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: isUser 
                          ? const Radius.circular(20) 
                          : const Radius.circular(4),
                      bottomRight: isUser 
                          ? const Radius.circular(4) 
                          : const Radius.circular(20),
                    ),
                  ),
                  child: isUser 
                      ? Text(
                          message.text,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        )
                      : MarkdownBody(
                          data: message.text,
                          styleSheet: MarkdownStyleSheet(
                            p: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              height: 1.4,
                            ),
                            strong: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            h1: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            h2: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            listBullet: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                            ),
                            code: TextStyle(
                              backgroundColor: Colors.grey.shade200,
                              fontSize: 14,
                            ),
                            codeblockDecoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          softLineBreak: true,
                        ),
                ),
                const SizedBox(height: 4),
                Text(
                  timeString,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          if (isUser) ...[
            const SizedBox(width: 8),
            // User avatar
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.textSecondary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.white,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }
}