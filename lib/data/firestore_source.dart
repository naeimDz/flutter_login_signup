import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product_model.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getproduct(
      String collection) async {
    try {
      var snapshot = await _firestore.collection(collection).get();
      return snapshot;
    } catch (e) {
      // Handle the error appropriately, e.g., log the error or throw a custom exception.
      throw Exception('Error fetching todos: $e');
    }
  }

  Future<void> addProduct(
      String collection, Map<String, dynamic> productData) async {
    try {
      await _firestore.collection(collection).add(productData);
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  Future<void> updateProduct(String collection, String productId,
      Map<String, dynamic> productData) async {
    try {
      await _firestore
          .collection(collection)
          .doc(productId)
          .update(productData);
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> removeProduct(String collection, String productId) async {
    try {
      await _firestore.collection(collection).doc(productId).delete();
    } catch (e) {
      throw Exception('Error removing product: $e');
    }
  }

  static Future<void> initializeFirestoreWithProducts() async {
    for (Product product in products) {
      await _firestore.collection('products').add({
        'id': product.id,
        'price': product.price,
        'title': product.title,
        'image': product.image,
        'description': product.description,
        'isFavorite': false,
        'isPurchased': false,
      });
    }
  }
}
