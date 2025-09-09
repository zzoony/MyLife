import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/chatbot_service.dart';
import '../widgets/message_bubble.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatbotService _chatbotService = ChatbotService();
  final List<Message> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _addMessage(Message.bot('안녕하세요! 저는 AI 챗봇 입니다.\n무엇을 도와드릴까요?'));
  }

  void _addMessage(Message message) {
    setState(() {
      _messages.add(message);
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isLoading) return;

    // Clear input and add user message
    _messageController.clear();
    _addMessage(Message.user(text));

    // Show loading state
    setState(() {
      _isLoading = true;
    });

    try {
      // Get response from chatbot service using blocking mode
      final response = await _chatbotService.sendMessage(text);
      _addMessage(Message.bot(response));
    } catch (e) {
      _addMessage(Message.bot('죄송합니다. 일시적인 오류가 발생했습니다. 다시 시도해 주세요.\n오류: $e'));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          AppConstants.chatbotTitle,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.white),
            onPressed: () {
              // Show options menu
              _showOptionsMenu(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _messages.length) {
                  return MessageBubble(message: _messages[index]);
                } else {
                  // Loading indicator
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.chatBotBubble,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '답변을 준비하고 있습니다...',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          
          // Message input area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Text input field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: AppColors.divider,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: '무엇이든 물어보세요.',
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                        enabled: !_isLoading,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Send button
                  GestureDetector(
                    onTap: _isLoading ? null : _sendMessage,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _isLoading 
                            ? AppColors.textSecondary.withOpacity(0.5)
                            : AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: AppColors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('대화 기록 삭제'),
              onTap: () {
                Navigator.pop(context);
                _clearMessages();
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('도움말'),
              onTap: () {
                Navigator.pop(context);
                _showHelpDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _clearMessages() {
    setState(() {
      _messages.clear();
    });
    // Reset conversation in service
    _chatbotService.resetConversation();
    _addMessage(Message.bot('안녕하세요! 저는 AI 챗봇 입니다.\n무엇을 도와드릴까요?'));
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('POS 헬프봇 도움말'),
        content: const Text(
          '• GS25 POS 시스템 운영과 관련된 질문을 해보세요.\n'
          '• 상품, POS 기능, 매장 관리에 대해 도움을 받을 수 있습니다.\n'
          '• 구체적인 질문일수록 더 정확한 답변을 받을 수 있습니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}