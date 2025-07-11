import 'dart:developer';

import 'package:cakes_store_frontend/features/orders/presentation/cubit/orders_cubit/get_orders_cubit.dart';
import 'package:cakes_store_frontend/features/orders/presentation/cubit/orders_cubit/order_cubit_states.dart';
import 'package:cakes_store_frontend/features/orders/presentation/screen/empty_order_screen.dart';
import 'package:cakes_store_frontend/features/orders/presentation/screen/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Orders"),),
      body: BlocBuilder<GetOrdersCubit, OrderStates>(
        builder: (context, state) {
          if (state is OrdersInitialState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrdersLoadedState) {
            return state.orders.isEmpty
                ? EmptyOrderScreen()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      final order = state.orders[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          title: Text(
                            'Order #$index',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            'Placed on ${order.createdAt?.toLocal()}', // format date if needed
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                          ),
                          onTap: ()async {
                             await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        OrderDetailsScreen(order: order),
                              ),
                            );
                            context.read<GetOrdersCubit>().getOrders(order.userId);
                          },
                        ),
                      );
                    },
                  
                );
          } else if (state is OrdersFailureState) {
            log(state.toString());
            return Center(
              child: Column(
                children: [
                  Spacer(),
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset('assets/images/error.png')),
                  Text('Oops !! there is an error'),
                  Text(state.errorMessage),
                  Spacer()
                ],
              ),
            );
          }else if(state is InvalidUserIdState){
            return Center(child: Text('You ust login first !!'),);
          }
          return Center(child: Text("Some thing wrong with data provider state"));
        },
      ),
    );
  }
}
