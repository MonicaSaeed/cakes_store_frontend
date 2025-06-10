import 'package:cakes_store_frontend/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class ThemeShowcaseScreen extends StatelessWidget {
  const ThemeShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Showcase')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('headlineLarge', style: textTheme.headlineLarge),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    ThemeController.toggleTheme();
                  },
                  child: Text('Toggle theme'),
                ),
              ],
            ),

            // TEXT THEMES
            const SizedBox(height: 8),
            Text('bodyLarge', style: textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('bodyMedium', style: textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text('labelLarge', style: textTheme.labelLarge),
            const Divider(),

            // BUTTON THEMES
            const Text(
              'Buttons:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('ElevatedButton'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('OutlinedButton'),
            ),
            TextButton(onPressed: () {}, child: const Text('TextButton')),
            const Divider(),

            // INPUT FIELD
            const Text(
              'Input Field:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter text...',
                prefixIcon: const Icon(Icons.text_fields),
              ),
            ),
            const Divider(),

            // CHIP
            const Text('Chips:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: const [
                Chip(label: Text('Default')),
                //Chip(label: Text('Selected'), selected: true),
              ],
            ),
            const Divider(),

            // ICON
            const Text('Icon:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Icon(Icons.cake, size: 40),

            const Divider(),

            // CARD
            const Text('Card:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'This is a card using your cardTheme',
                  style: textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
