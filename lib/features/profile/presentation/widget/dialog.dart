import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final isDarkMode = colorScheme.brightness == Brightness.dark;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          'Choose Image Source',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.camera_alt,
                  color: isDarkMode ? colorScheme.secondary : null,
                ),
                SizedBox(width: 8),
                Text('Camera'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.photo_library,
                  color: isDarkMode ? colorScheme.secondary : null,
                ),
                SizedBox(width: 8),
                Text('Gallery'),
              ],
            ),
          ),
        ],
      );
    },
  );
}
