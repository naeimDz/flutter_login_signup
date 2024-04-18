// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on _ProductStoreBase, Store {
  late final _$productFutureAtom =
      Atom(name: '_ProductStoreBase.productFuture', context: context);

  @override
  ObservableFuture<void> get productFuture {
    _$productFutureAtom.reportRead();
    return super.productFuture;
  }

  @override
  set productFuture(ObservableFuture<void> value) {
    _$productFutureAtom.reportWrite(value, super.productFuture, () {
      super.productFuture = value;
    });
  }

  late final _$isFavoritedAtom =
      Atom(name: '_ProductStoreBase.isFavorited', context: context);

  @override
  bool get isFavorited {
    _$isFavoritedAtom.reportRead();
    return super.isFavorited;
  }

  @override
  set isFavorited(bool value) {
    _$isFavoritedAtom.reportWrite(value, super.isFavorited, () {
      super.isFavorited = value;
    });
  }

  late final _$isPurchasedAtom =
      Atom(name: '_ProductStoreBase.isPurchased', context: context);

  @override
  bool get isPurchased {
    _$isPurchasedAtom.reportRead();
    return super.isPurchased;
  }

  @override
  set isPurchased(bool value) {
    _$isPurchasedAtom.reportWrite(value, super.isPurchased, () {
      super.isPurchased = value;
    });
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('_ProductStoreBase.fetchProducts', context: context);

  @override
  Future<void> fetchProducts(String collection) {
    return _$fetchProductsAsyncAction
        .run(() => super.fetchProducts(collection));
  }

  late final _$addProductAsyncAction =
      AsyncAction('_ProductStoreBase.addProduct', context: context);

  @override
  Future<void> addProduct(String collection, Map<String, dynamic> productData) {
    return _$addProductAsyncAction
        .run(() => super.addProduct(collection, productData));
  }

  late final _$updateProductAsyncAction =
      AsyncAction('_ProductStoreBase.updateProduct', context: context);

  @override
  Future<void> updateProduct(
      String collection, String productId, Map<String, dynamic> productData) {
    return _$updateProductAsyncAction
        .run(() => super.updateProduct(collection, productId, productData));
  }

  late final _$removeProductAsyncAction =
      AsyncAction('_ProductStoreBase.removeProduct', context: context);

  @override
  Future<void> removeProduct(String collection, String productId) {
    return _$removeProductAsyncAction
        .run(() => super.removeProduct(collection, productId));
  }

  @override
  String toString() {
    return '''
productFuture: ${productFuture},
isFavorited: ${isFavorited},
isPurchased: ${isPurchased}
    ''';
  }
}
