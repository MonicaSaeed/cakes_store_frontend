import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    return ListTile(
      leading: Icon(
        icon,
        color:
            isDarkMode
                ? colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
      ),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      onTap: () {}, // You can handle navigation here
    );
  }
}
