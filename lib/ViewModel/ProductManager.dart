import 'package:like_eat/Model/Product.dart';

class ProductManager {
  Product _productToShow;

  ProductManager(Product product) {
    _productToShow =
        product; //ToDo mettere gli attributi necessari che devono contenere i dati da mostrare
  }

  void addInTheCart(int quantity) {}

  //Fare i relativi getter per far si che il widget possa leggere i dati del prodotto
}
