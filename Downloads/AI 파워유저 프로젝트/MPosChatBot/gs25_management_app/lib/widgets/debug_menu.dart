import 'package:flutter/material.dart';
import '../models/server_config.dart';
import '../services/debug_service.dart';
import '../utils/colors.dart';

class DebugMenu extends StatefulWidget {
  const DebugMenu({Key? key}) : super(key: key);

  @override
  State<DebugMenu> createState() => _DebugMenuState();
}

class _DebugMenuState extends State<DebugMenu> {
  final DebugService _debugService = DebugService();
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (!_debugService.isDebugMode) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<ServerConfig>(
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(
          Icons.bug_report,
          color: AppColors.primary,
          size: 20,
        ),
      ),
      onSelected: (ServerConfig server) {
        _debugService.setServer(server);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('서버가 ${server.displayName}으로 변경되었습니다.'),
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.primary,
          ),
        );
      },
      itemBuilder: (BuildContext context) {
        return ServerConfig.availableServers.map((ServerConfig server) {
          final bool isSelected = _debugService.currentServer.type == server.type;
          
          return PopupMenuItem<ServerConfig>(
            value: server,
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        server.displayName,
                        style: TextStyle(
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        server.type == ServerType.dify ? 'Default' : 'MISO Gateway',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}