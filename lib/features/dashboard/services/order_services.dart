import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firmer_city/features/dashboard/data/oder_model.dart';

class OrderServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _orderCollection =
      _firestore.collection('orders');

  static Stream<List<OrderModel>> getOrderById(String id) {
    var data =
        _orderCollection.snapshots();
    return data.map((event) {
     // print('event.docs: ${event.docs.length}');
      return event.docs
          .map((e) => OrderModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  static Future<bool> createOrder(OrderModel order) async {
    try {
      await _orderCollection.doc(order.id).set(order.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateOrder(OrderModel order) async {
    try {
      await _orderCollection.doc(order.id).update(order.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static String generateOrderId() {
    return _orderCollection.doc().id;
  }
}
