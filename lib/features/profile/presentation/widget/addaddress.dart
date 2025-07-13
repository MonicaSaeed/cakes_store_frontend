import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Row addaddresas(BuildContext context, Function() addAddressField) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final isDarkMode = colorScheme.brightness == Brightness.dark;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton.icon(
        onPressed: addAddressField,
        label: Text(
          'Add Address',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        icon: Icon(Icons.add, color: isDarkMode ? colorScheme.secondary : null),
      ),
    ],
  );
}
