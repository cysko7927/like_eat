import 'Product.dart';

class Notifications {
  Product _referenceProduct;
  String _message;

  Notifications(
    this._referenceProduct,
    this._message,
  );

  Product get referenceProduct => _referenceProduct;
  String get message => _message;
  set referenceProduct(Product product) => _referenceProduct = product;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Notifications && o._referenceProduct == _referenceProduct;
  }

  @override
  int get hashCode => _referenceProduct.hashCode;
}
