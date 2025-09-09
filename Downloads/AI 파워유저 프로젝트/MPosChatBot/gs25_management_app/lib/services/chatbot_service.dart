import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';
import '../models/server_config.dart';
import 'debug_service.dart';

class ChatbotService {
  final DebugService _debugService = DebugService();
  
  String? _conversationId;
  String? _userId;

  ChatbotService() {
    // Generate a unique user ID for this session
    _userId = 'user-${DateTime.now().millisecondsSinceEpoch}';
  }

  // Streaming chat method
  Stream<String> sendMessageStream(String message) async* {
    try {
      final currentServer = _debugService.currentServer;
      
      if (currentServer.type == ServerType.miso) {
        // MISO 서버는 workflows/run 엔드포인트 사용
        final uri = Uri.parse('${currentServer.baseUrl}/workflows/run');
        
        print('MISO Streaming API URL: $uri');
        print('MISO Authorization: Bearer ${currentServer.apiToken}');
        
        final response = await http.post(
          uri,
          headers: {
            'Authorization': 'Bearer ${currentServer.apiToken}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'inputs': {'input_text': message},
            'response_mode': 'streaming',
            'conversation_id': _conversationId ?? '',
            'user': _userId ?? 'abc-123',
          }),
        );
        
        if (response.statusCode == 200) {
          // MISO API는 streaming이 아닌 blocking 응답을 줄 수 있음
          try {
            final data = jsonDecode(response.body);
            if (data['data'] != null && 
                data['data']['outputs'] != null && 
                data['data']['outputs']['result'] != null) {
              String answer = data['data']['outputs']['result'].toString();
              yield answer;
            } else {
              yield '죄송합니다. MISO 서버 응답을 처리할 수 없습니다.';
            }
          } catch (e) {
            // 만약 streaming 응답이라면 기존 방식으로 처리
            final lines = response.body.split('\n');
            String fullAnswer = '';
            
            for (String line in lines) {
              if (line.trim().isEmpty) continue;
              
              try {
                String jsonLine = line.startsWith('data: ') ? line.substring(6) : line;
                final lineData = jsonDecode(jsonLine);
                
                if (lineData['event'] == 'message') {
                  if (lineData['conversation_id'] != null) {
                    _conversationId = lineData['conversation_id'];
                  }
                  
                  if (lineData['answer'] != null) {
                    String answer = lineData['answer'];
                    fullAnswer += answer;
                    yield answer;
                  }
                }
              } catch (e) {
                continue;
              }
            }
            
            if (fullAnswer.isEmpty) {
              yield '죄송합니다. 응답을 처리하는 중 오류가 발생했습니다.';
            }
          }
        } else {
          yield 'MISO 서버 오류가 발생했습니다. (상태 코드: ${response.statusCode})';
        }
      } else {
        // Dify 서버는 기존 방식 사용
        final response = await http.post(
          Uri.parse('${currentServer.baseUrl}/chat-messages'),
          headers: {
            'Authorization': 'Bearer ${currentServer.apiToken}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'inputs': {},
            'query': message,
            'response_mode': 'streaming',
            'conversation_id': _conversationId ?? '',
            'user': _userId ?? 'abc-123',
          }),
        );

        if (response.statusCode == 200) {
          // Dify API는 때로는 streaming이 아닌 blocking 응답을 줄 수 있음
          try {
            final data = jsonDecode(response.body);
            if (data['answer'] != null) {
              // Blocking 응답인 경우
              if (data['conversation_id'] != null) {
                _conversationId = data['conversation_id'];
              }
              String answer = data['answer'].toString();
              yield answer;
            } else {
              yield '죄송합니다. Dify 서버 응답을 처리할 수 없습니다.';
            }
          } catch (e) {
            // 만약 streaming 응답이라면 기존 방식으로 처리
            final lines = response.body.split('\n');
            String fullAnswer = '';
            
            for (String line in lines) {
              if (line.trim().isEmpty) continue;
              
              try {
                // Remove "data: " prefix if present
                String jsonLine = line.startsWith('data: ') ? line.substring(6) : line;
                
                final lineData = jsonDecode(jsonLine);
                
                if (lineData['event'] == 'message') {
                  // Store conversation_id for future messages
                  if (lineData['conversation_id'] != null) {
                    _conversationId = lineData['conversation_id'];
                  }
                  
                  // Extract the answer content
                  if (lineData['answer'] != null) {
                    String answer = lineData['answer'];
                    fullAnswer += answer;
                    yield answer; // Stream each part
                  }
                }
              } catch (e) {
                // Skip malformed JSON lines
                continue;
              }
            }
            
            // If no streaming content was found, return the full answer
            if (fullAnswer.isEmpty) {
              yield '죄송합니다. 응답을 처리하는 중 오류가 발생했습니다.';
            }
          }
        } else {
          yield '서버 오류가 발생했습니다. (상태 코드: ${response.statusCode})';
        }
      }
    } catch (e) {
      yield '네트워크 오류가 발생했습니다: $e';
    }
  }

  // Non-streaming method for compatibility
  Future<String> sendMessage(String message) async {
    try {
      final currentServer = _debugService.currentServer;
      print('Sending message to ${currentServer.displayName}: $message');
      print('Using conversation_id: $_conversationId');
      
      late Map<String, dynamic> requestBody;
      
      if (currentServer.type == ServerType.miso) {
        // MISO API는 inputs에 input_text 사용
        requestBody = {
          'inputs': {'input_text': message},
          'response_mode': 'blocking',
          'user': _userId ?? 'abc-123',
        };
      } else {
        // Dify API는 기존 방식 사용
        requestBody = {
          'inputs': {},
          'query': message,
          'response_mode': 'blocking',
          'user': _userId ?? 'abc-123',
        };
      }
      
      // Only add conversation_id if it exists
      if (_conversationId != null && _conversationId!.isNotEmpty) {
        requestBody['conversation_id'] = _conversationId!;
      }
      
      late http.Response response;
      
      if (currentServer.type == ServerType.miso) {
        // MISO 서버는 workflows/run 엔드포인트 사용
        final uri = Uri.parse('${currentServer.baseUrl}/workflows/run');
        
        print('MISO API URL: $uri');
        print('MISO Authorization: Bearer ${currentServer.apiToken}');
        print('MISO Request Body: ${jsonEncode(requestBody)}');
        
        response = await http.post(
          uri,
          headers: {
            'Authorization': 'Bearer ${currentServer.apiToken}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );
      } else {
        // Dify 서버는 헤더 방식 사용
        response = await http.post(
          Uri.parse('${currentServer.baseUrl}/chat-messages'),
          headers: {
            'Authorization': 'Bearer ${currentServer.apiToken}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // MISO API vs Dify API 응답 구조에 따른 파싱
        String answer;
        if (currentServer.type == ServerType.miso) {
          // MISO API: data.data.outputs.result
          if (data['data'] != null && 
              data['data']['outputs'] != null && 
              data['data']['outputs']['result'] != null) {
            answer = data['data']['outputs']['result'].toString();
          } else {
            return '죄송합니다. MISO 서버 응답을 처리할 수 없습니다.';
          }
        } else {
          // Dify API: answer 필드 직접 사용
          if (data['conversation_id'] != null) {
            _conversationId = data['conversation_id'];
            print('Updated conversation_id: $_conversationId');
          }
          answer = data['answer']?.toString() ?? '';
        }
        
        if (answer.isNotEmpty) {
          return answer;
        } else {
          return '죄송합니다. 응답을 받지 못했습니다.';
        }
      } else {
        print('API Error Response: ${response.body}');
        throw Exception('${currentServer.displayName} 서버 오류 (상태 코드: ${response.statusCode})');
      }
    } catch (e) {
      print('Error in sendMessage: $e');
      throw Exception('네트워크 오류: $e');
    }
  }

  // Reset conversation for new chat session
  void resetConversation() {
    _conversationId = null;
    _userId = 'user-${DateTime.now().millisecondsSinceEpoch}';
  }

  // Get current conversation ID
  String? get conversationId => _conversationId;
}