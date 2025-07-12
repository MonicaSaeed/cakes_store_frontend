import 'package:cakes_store_frontend/features/profile/data/webservice/profile_firebaseservice.dart';
import 'package:flutter/material.dart';

void confirmDeleteAccount(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Are you sure?'),
      content: Text('This will permanently delete your account.'),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Delete', style: TextStyle(color: Colors.red)),
          onPressed: () async {
            Navigator.of(context).pop(); 
            await deleteAccount(context);
          },
        ),
      ],
    ),
  );
}
