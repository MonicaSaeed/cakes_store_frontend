import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: 600,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '$label ',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            const SizedBox(width: 8), // optional space between label and value
             Text(value, style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }
}
