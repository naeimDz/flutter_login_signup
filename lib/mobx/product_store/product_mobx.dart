import 'package:mobx/mobx.dart';

import '../../data/firestore_source.dart';
part 'product_mobx.g.dart';

class ProductStore = _ProductStoreBase with _$ProductStore;

abstract class _ProductStoreBase with Store {
  final FirestoreService _firestoreService = FirestoreService();

  @observable
ObservableFuture<void> productFuture = ObservableFuture<void>(Future.value());

  @observable
  bool isFavorited = false;
  @observable
  bool isPurchased = false;

  @action
  Future<void> fetchProducts(String collection) async {
    await Future.delayed(const Duration(seconds: 1));
    productFuture = ObservableFuture(_firestoreService.getproduct(collection));
    await productFuture;
  }

  @action
  Future<void> addProduct(
      String collection, Map<String, dynamic> productData) async {
    await Future.delayed(const Duration(seconds: 1));
    productFuture =
        ObservableFuture(_firestoreService.addProduct(collection, productData));
    await productFuture;
  }

  @action
  Future<void> updateProduct(String collection, String productId,
      Map<String, dynamic> productData) async {
    await Future.delayed(const Duration(seconds: 1));
    productFuture = ObservableFuture(
        _firestoreService.updateProduct(collection, productId, productData));
    await productFuture;
  }

  @action
  Future<void> removeProduct(String collection, String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    productFuture = ObservableFuture(
        _firestoreService.removeProduct(collection, productId));
    await productFuture;
  }
}
