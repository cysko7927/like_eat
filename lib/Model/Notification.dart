import 'dart:convert';

import 'Product.dart';

class Notifications {
  Product _referenceProduct;

  Notifications(
    this._referenceProduct,
  );

  Product get referenceProduct => _referenceProduct;
  set referenceProduct(Product product) => _referenceProduct = product;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Notifications && o._referenceProduct == _referenceProduct;
  }

  @override
  int get hashCode => _referenceProduct.hashCode;
}
