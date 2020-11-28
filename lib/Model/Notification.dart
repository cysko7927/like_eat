import 'Product.dart';

class Notification {
  Product _referenceProduct;

  Notification(this._referenceProduct);

  Product get referenceProductGet => _referenceProduct;
  set referenceProductSet(Product product) => _referenceProduct = product;
}
