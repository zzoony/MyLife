import '../models/server_config.dart';

class DebugService {
  static final DebugService _instance = DebugService._internal();
  factory DebugService() => _instance;
  DebugService._internal();

  ServerConfig _currentServer = ServerConfig.difyServer;

  ServerConfig get currentServer => _currentServer;

  void setServer(ServerConfig server) {
    _currentServer = server;
  }

  bool get isDebugMode => true; // 디버그 모드 여부를 설정할 수 있습니다.
}