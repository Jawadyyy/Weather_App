import 'package:flutter/material.dart';

class NotificationsSheet extends StatelessWidget {
  const NotificationsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A3A3A),
                  ),
                ),
                SizedBox(height: 8),
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
                  message: 'A sunny day in your location, consider wearing your UV protection.',
                  backgroundColor: Color(0xFFE9F5FE),
                ),
                SizedBox(height: 16),
                NotificationCategoryTitle(title: "Earlier"),
                NotificationItem(
                  icon: Icons.cloud_outlined,
                  time: '1 day ago',
                  message: "A cloudy day will occur all day long, don't worry about the heat of the sun.",
                  backgroundColor: Colors.white,
                ),
                NotificationItem(
                  icon: Icons.umbrella_outlined,
                  time: '2 days ago',
                  message: "Potential for rain today is 84%, don't forget to bring your umbrella.",
                  backgroundColor: Colors.white,
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
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
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(message),
              ],
            ),
          ),
          Icon(Icons.expand_more, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
