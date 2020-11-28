import 'Product.dart';

class Notification {
  Product _referenceProduct;

  Notification(this._referenceProduct);

  Product get referenceProduct => _referenceProduct;
  set referenceProduct(Product product) => _referenceProduct = product;
}
