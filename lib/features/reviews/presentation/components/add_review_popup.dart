import 'package:cakes_store_frontend/core/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddReviewPopup extends StatefulWidget {
  final String productId;

  const AddReviewPopup({super.key, required this.productId});

  @override
  State<AddReviewPopup> createState() => _AddReviewPopupState();
}

class _AddReviewPopupState extends State<AddReviewPopup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  double _rating = 5.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: MediaQuery.of(context).viewInsets.bottom + 40,
      ),
      child: Form(
        key: _formKey,
        child: Wrap(
          children: [
            Center(
              child: Text(
                'Add Review',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              title: 'Write your review',
              controller: _contentController,
              maxLines: 3,
              hintText: 'Enter your review here',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Rating'),
                Expanded(
                  child: Slider(
                    value: _rating,
                    onChanged: (value) {
                      setState(() => _rating = value);
                    },
                    min: 1,
                    max: 5,
                    divisions: 8,
                    label: _rating.toStringAsFixed(1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
