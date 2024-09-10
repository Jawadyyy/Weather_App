import 'package:flutter/material.dart';

class NotificationsSheet extends StatelessWidget {
  const NotificationsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            spreadRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle for the bottom sheet
          Container(
            height: 6,
            width: 50,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          // Header Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Notifications',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
              ],
            ),
          ),
          // Notification List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                NotificationCategoryTitle(title: "New"),
                NotificationItem(
                  icon: Icons.wb_sunny_outlined,
                  time: '10 minutes ago',
                  message: 'It\'s sunny in your area. Remember to wear UV protection.',
                  backgroundColor: Color(0xFFE9F5FE),
                ),
                SizedBox(height: 16),
                NotificationCategoryTitle(title: "Earlier"),
                NotificationItem(
                  icon: Icons.cloud_outlined,
                  time: '1 day ago',
                  message: "It's going to be cloudy all day. You won't need sunscreen.",
                  backgroundColor: Color(0xFFF7F7F7),
                ),
                NotificationItem(
                  icon: Icons.umbrella_outlined,
                  time: '2 days ago',
                  message: "There's an 84% chance of rain. Don't forget your umbrella!",
                  backgroundColor: Color(0xFFF7F7F7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCategoryTitle extends StatelessWidget {
  final String title;

  const NotificationCategoryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6C757D),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String time;
  final String message;
  final Color backgroundColor;

  const NotificationItem({
    super.key,
    required this.icon,
    required this.time,
    required this.message,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF3A3A3A),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.more_vert, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
