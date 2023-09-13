import 'package:nike_ecommerce/data/product.dart';

class SubmitOrderParams {
  final String firstName;
  final String lastName;
  final String postalCode;
  final String phone;
  final String address;
  final PaymentMethod paymentMethod;

  const SubmitOrderParams(this.firstName, this.lastName, this.postalCode,
      this.phone, this.address, this.paymentMethod);
}

enum PaymentMethod { online, cashOnDelivery }

class SubmitOrderResult {
  final int orderId;
  final String bankGatewayUrl;

  SubmitOrderResult(this.orderId, this.bankGatewayUrl);

  SubmitOrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGatewayUrl = json['bank_gateway_url'];
}

class OrderEntity {
  final int id;
  final int payablePrice;
  final List<ProductEntity> items;

  OrderEntity(this.id, this.payablePrice, this.items);

  OrderEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        payablePrice = json['payable'],
        items = (json['order_items'] as List)
            .map((item) => ProductEntity.fromJson(item['product']))
            .toList();
}
