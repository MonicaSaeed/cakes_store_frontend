import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final int quantity;
  const QuantitySelector({super.key, this.quantity = 1});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity; // initialize from widget
  }

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: decrement,
                splashRadius: 20,
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text('$quantity', style: const TextStyle(fontSize: 16)),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: increment,
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
