import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_text_field.dart';
import '../../../../core/services/toast_helper.dart';
import '../../data/models/add_review_model.dart';
import '../cubit/reviews_cubit.dart';

class AddReviewPopup extends StatefulWidget {
  final String productId;
  final String userId;

  const AddReviewPopup({
    super.key,
    required this.productId,
    required this.userId,
  });

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
      child: BlocListener<ReviewsCubit, ReviewsState>(
        listener: (context, state) {
          if (state is ReviewAdded) {
            Navigator.of(context).pop();
            ToastHelper.showToast(
              message: state.message,
              context: context,
              toastType: ToastType.success,
            );
          } else if (state is ReviewAddError) {
            Navigator.of(context).pop();
            ToastHelper.showToast(
              message: state.errorMessage,
              context: context,
              toastType: ToastType.error,
            );
          }
        },
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
              BlocBuilder<ReviewsCubit, ReviewsState>(
                builder: (context, state) {
                  final isLoading = state is ReviewAddLoading;

                  return Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    final review = AddReviewModel(
                                      productId: widget.productId,
                                      userId: widget.userId,
                                      rating: _rating,
                                      comment: _contentController.text.trim(),
                                    );
                                    context.read<ReviewsCubit>().addReview(
                                      review,
                                    );
                                  }
                                },
                        child:
                            isLoading
                                ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Submitting...',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                : const Text('Submit'),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
