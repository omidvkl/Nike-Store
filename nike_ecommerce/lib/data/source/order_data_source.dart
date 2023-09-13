import 'package:dio/dio.dart';
import 'package:nike_ecommerce/data/order.dart';
import 'package:nike_ecommerce/data/payment_receipt.dart';

abstract class IOrderDataSource {
  Future<SubmitOrderResult> submitOrder(SubmitOrderParams params);
  Future<PaymentReceiptData> getPaymentReceipt(int orderId);
  Future<List<OrderEntity>> getOrders();
}

class OrderRemoteDataSource implements IOrderDataSource {
  final Dio httpClient;

  OrderRemoteDataSource(this.httpClient);


  @override
  Future<SubmitOrderResult> submitOrder(SubmitOrderParams params) async {
    final response = await httpClient.post('order/submit', data: {
      'first_name': params.firstName,
      'last_name': params.lastName,
      'postal_code': params.postalCode,
      'mobile': params.phone,
      'address': params.address,
      'payment_method': params.paymentMethod == PaymentMethod.cashOnDelivery
          ? 'cash_on_delivery'
          : 'online'
    });
    return SubmitOrderResult.fromJson(response.data);
  }

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) async{
    final response = await httpClient.get('order/checkout?order_id=$orderId');
    return PaymentReceiptData.fromJson(response.data);
  }

  @override
  Future<List<OrderEntity>> getOrders()async {
    final response =await httpClient.get('order/list');
    return (response.data as List).map((item) => OrderEntity.fromJson(item)).toList();
  }

}