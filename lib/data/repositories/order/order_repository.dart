import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/shop/model/order_model.dart';
import '../authentication/authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty)
        throw 'Unable to find user information. Try after a moment.';

      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      print('########## fetch user address in repo $result');
      return result.docs
          .map((documentSnap) => OrderModel.fromSnapshot(documentSnap))
          .toList();
    } catch (e) {
      print('order error $e');
      throw "Something went wrong while fetching order info.";
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      print('add order error $e');
      throw "Something went wrong while add order data.";
    }
  }
}
