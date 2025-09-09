import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;
  final bool isClickable;

  const MenuItem({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.isClickable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: isClickable ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Icon
              Text(
                icon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 16),
              
              // Title
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              
              // Arrow indicator
              Icon(
                Icons.chevron_right,
                size: 24,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}