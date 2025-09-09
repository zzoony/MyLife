import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../widgets/store_info_card.dart';
import '../widgets/menu_item.dart';
import '../widgets/debug_menu.dart';
import 'chatbot_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  void _navigateToChatbot() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatbotScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          AppConstants.appTitle,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          const DebugMenu(),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.textSecondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Store Info Card
          const StoreInfoCard(),
          
          // Tab section (챗봇/공지사항)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedTabIndex = 0);
                      _navigateToChatbot();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: _selectedTabIndex == 0 
                            ? AppColors.primary 
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 16,
                            color: _selectedTabIndex == 0 
                                ? AppColors.white 
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '챗봇',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _selectedTabIndex == 0 
                                  ? AppColors.white 
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTabIndex = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: _selectedTabIndex == 1 
                            ? AppColors.primary 
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.campaign,
                            size: 16,
                            color: _selectedTabIndex == 1 
                                ? AppColors.white 
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '공지사항',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _selectedTabIndex == 1 
                                  ? AppColors.white 
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Menu items
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // General menu items
                  MenuItem(
                    title: '상품판매',
                    icon: '🛍️',
                  ),
                  const SizedBox(height: 4),
                  MenuItem(
                    title: '영수증',
                    icon: '📄',
                  ),
                  const SizedBox(height: 4),
                  MenuItem(
                    title: '배달 서비스',
                    icon: '🚚',
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Store management section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      '매장관리',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  MenuItem(
                    title: '점포관리',
                    icon: '📋',
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Product settings section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      '상품 설정',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  MenuItem(
                    title: '우리점포 상품설정',
                    icon: '👤',
                  ),
                  const SizedBox(height: 4),
                  MenuItem(
                    title: '봉투 설정',
                    icon: '🔒',
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // System settings section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      '시스템 설정',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  MenuItem(
                    title: 'POS 진단',
                    icon: '📱',
                  ),
                  const SizedBox(height: 4),
                  MenuItem(
                    title: '사운드 설정',
                    icon: '🔊',
                  ),
                  const SizedBox(height: 4),
                  MenuItem(
                    title: '시스템 재부팅',
                    icon: '🔄',
                  ),
                  
                  const SizedBox(height: 100), // Space for bottom navigation
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.white,
        currentIndex: 3, // 전체메뉴 selected
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: '상품판매',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: '영수증',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '전체메뉴',
          ),
        ],
      ),
    );
  }
}