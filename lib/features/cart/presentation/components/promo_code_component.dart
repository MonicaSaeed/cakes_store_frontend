import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_text_field.dart';
import '../../../../core/services/toast_helper.dart';
import '../cubit/promo_code_cubit/promo_code_cubit.dart';
import '../cubit/promo_code_cubit/promo_code_state.dart';

class PromoCodeSection extends StatefulWidget {
  final double cartTotal;
  final void Function(double discountedTotal,String promoCode,int promoDiscount) onDiscountApplied;

  const PromoCodeSection({
    super.key,
    required this.cartTotal,
    required this.onDiscountApplied,
  });

  @override
  State<PromoCodeSection> createState() => _PromoCodeSectionState();
}

class _PromoCodeSectionState extends State<PromoCodeSection> {
  final _promoCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PromoCodeCubit, PromoCodeState>(
      listener: (context, state) {
        if (state is PromoCodeNotFound) {
          ToastHelper.showToast(
            context: context,
            message: state.errorMessage,
            toastType: ToastType.error,
          );
        }

        if (state is PromoCodeActivated && !state.isActive) {
          ToastHelper.showToast(
            context: context,
            message: 'Promo code is inactive',
            toastType: ToastType.warning,
          );
        }

        if (state is PromoCodeFound) {
          ToastHelper.showToast(
            context: context,
            message: 'Promo code applied successfully!',
            toastType: ToastType.success,
          );
          final discount = state.promoCode.discountPercentage;
          final discountedTotal = widget.cartTotal * (1 - discount / 100);
          widget.onDiscountApplied(discountedTotal,state.promoCode.code,discount);
        }
      },
      builder: (context, state) {
        int? discountPercent;
        double totalAfterDiscount = widget.cartTotal;

        if (state is PromoCodeFound) {
          discountPercent = state.promoCode.discountPercentage;
          totalAfterDiscount = widget.cartTotal * (1 - discountPercent / 100);
        }

        return Column(
          children: [
            Form(
              key: _formKey,
              child: CustomTextField(
                controller: _promoCodeController,
                hintText: 'Enter promo code',
                title: 'Apply Promo Code',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final enteredCode = _promoCodeController.text.trim();
                      context.read<PromoCodeCubit>()
                        ..promoCode = enteredCode
                        ..getPromoCodeByCode();
                    }
                  },
                ),
              ),
            ),
            if (state is PromoCodeFound)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Promo applied: -$discountPercent%',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: Colors.green),
                ),
              ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          if (state is PromoCodeFound)
                            Text(
                              'EGP ${widget.cartTotal.toStringAsFixed(2)}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          if (state is PromoCodeFound) const SizedBox(width: 8),
                          Text(
                            'EGP ${totalAfterDiscount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
