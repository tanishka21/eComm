import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/model/cart_model.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';

import '../../../utils/constants/enums.dart';
import '../../personalization/models/address_model.dart';

class OrderModel {
  String id;
  String userId;
  OrderStatus status;
  double totalAmount;
  DateTime orderDate;
  String paymentMethod;
  AddressModel? address;
  DateTime? deliveryDate;
  List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    this.address,
    this.deliveryDate,
  });

  /// Empty helper function
  String get formattedOrderDate => THelperFunction.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunction.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? "Delivered"
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  /// Convert model to Json structure so that we can store data in firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  /// Map Json oriented document snapshot from firebase to usermodel
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    /// Map JSON Record to the model
    return OrderModel(
        id: data['id'] as String,
        userId: data['id'] as String,
        status: OrderStatus.values
            .firstWhere((e) => e.toString() == data['status']),
        paymentMethod: data['paymentMethod'] as String,
        address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
        deliveryDate: data['deliveryDate'] == null
            ? null
            : (data['deliveryDate'] as Timestamp).toDate(),
        items: (data['items'] as List<dynamic>)
            .map((itemData) =>
                CartItemModel.fromJson(itemData as Map<String, dynamic>))
            .toList(),
        totalAmount: data['totalAmount'] as double,
        orderDate: (data['orderDate'] as Timestamp).toDate());
  }
}
