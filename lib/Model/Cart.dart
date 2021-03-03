import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/User.dart';

class Cart {
  UserApp _user;
  Map<Product, int> _productsAndQuantity;

  Cart(this._user) {
    _productsAndQuantity = {};
  }

  //Getter

  UserApp get user => _user;
  Map<Product, int> get productAndQuantity => createMapProduct();
  Set<Product> get productsInCart =>
      _productsAndQuantity.keys; //Obtain all the products in the map

  //Setter
  void addProductAndQuantity(Product product, int quantity) {
    _productsAndQuantity[product] = quantity;
  }

  void removeProductAndQuantity(Product product, int quantity) {
    int qua = _productsAndQuantity[product];

    if (qua ==
        quantity) //If the quantity in the input is equal at that in the cart
      _productsAndQuantity.remove(product); //remove the product from the map
    else
      _productsAndQuantity[product] = qua - quantity; //Else update the quantity
  }

  //Utility

  Map<Product, int> createMapProduct() {
    Map<Product, int> map = new Map<Product, int>();
    map.addAll(_productsAndQuantity);
    return map;
  }
}
