enum ServerType {
  dify,
  miso,
}

class ServerConfig {
  final ServerType type;
  final String baseUrl;
  final String apiToken;
  final String displayName;

  const ServerConfig({
    required this.type,
    required this.baseUrl,
    required this.apiToken,
    required this.displayName,
  });

  static const ServerConfig difyServer = ServerConfig(
    type: ServerType.dify,
    baseUrl: 'https://dify.zipsa.shop/v1',
    apiToken: 'app-tsv1MHlYNjqzGLr4QbBvyJ7N',
    displayName: 'Dify Server',
  );

  static const ServerConfig misoServer = ServerConfig(
    type: ServerType.miso,
    baseUrl: 'https://gateway.ax.gsretail.com/ext/v1',
    apiToken: 'app-meLp6WRquzQ8yAyvzK2g8eWb',
    displayName: 'MISO Server',
  );

  static const List<ServerConfig> availableServers = [
    difyServer,
    misoServer,
  ];
}