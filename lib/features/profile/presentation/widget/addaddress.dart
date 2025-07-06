
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Row addaddresas(BuildContext context, Function() addAddressField) {           
                     return  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon( 
                            onPressed: addAddressField, 
                            label:Text(
                              'Add Address',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            icon: const Icon(Icons.add),
                            ),
                        ],
             );
}