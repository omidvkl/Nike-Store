import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce/data/order.dart';
import 'package:nike_ecommerce/data/repo/order_repository.dart';
import 'package:nike_ecommerce/ui/cart/price_info.dart';
import 'package:nike_ecommerce/ui/payment_webview.dart';
import 'package:nike_ecommerce/ui/receipt/payment_receipt.dart';
import 'package:nike_ecommerce/ui/shipping/bloc/shipping_bloc.dart';

class ShippingScreen extends StatefulWidget {
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;

  const ShippingScreen({
    super.key,
    required this.payablePrice,
    required this.shippingCost,
    required this.totalPrice,
  });

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  StreamSubscription? subscription;
  final firstNameController = TextEditingController(text: 'سعید');
  final lastNameController = TextEditingController(text: 'شاهینی');
  final phoneNumberController = TextEditingController(text: '09123445678');
  final postalCodeController = TextEditingController(text: '1234567890');
  final addressController = TextEditingController(
      text: 'سعادت آباد، میدان کاج، خیابان مروارید، پلاک ۱۳');

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          subscription = bloc.stream.listen((event) {
            if (event is ShippingSuccess) {
              if (event.data.bankGatewayUrl.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentGatewayScreen(
                            bankGatewayUrl: event.data.bankGatewayUrl)));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentReceiptScreen(
                              orderId: event.data.orderId,
                            )));
              }
            } else if (event is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(event.exception.message)));
            }
          });

          return bloc;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(label: Text('نام')),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(label: Text('نام خانوادگی')),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: postalCodeController,
                decoration: InputDecoration(label: Text('کد پستی')),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(label: Text('شماره تماس')),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(label: Text('آدرس تحویل گیرنده')),
              ),
              const SizedBox(
                height: 12,
              ),
              PriceInfo(
                  payablePrice: widget.payablePrice,
                  shippingCost: widget.shippingCost,
                  totalPrice: widget.totalPrice),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return state is ShippingLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  BlocProvider.of<ShippingBloc>(context)
                                      .add(ShippingSubmit(
                                    SubmitOrderParams(
                                        firstNameController.text,
                                        lastNameController.text,
                                        phoneNumberController.text,
                                        postalCodeController.text,
                                        addressController.text,
                                        PaymentMethod.cashOnDelivery),
                                  ));
                                },
                                child: const Text('پرداخت در محل')),
                            const SizedBox(
                              width: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<ShippingBloc>(context)
                                      .add(ShippingSubmit(
                                    SubmitOrderParams(
                                        firstNameController.text,
                                        lastNameController.text,
                                        phoneNumberController.text,
                                        postalCodeController.text,
                                        addressController.text,
                                        PaymentMethod.online),
                                  ));
                                },
                                child: const Text('پرداخت اینترنتی')),
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
