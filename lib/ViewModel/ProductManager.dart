import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';

class ProductManager {
  Product _productToShow;
  bool _observed;

  ProductManager(Product product) {
    _productToShow =
        product; //ToDo mettere gli attributi necessari che devono contenere i dati da mostrare
  }

  //Add in the cart a product with a specified quantity choose by user
  void addInTheCart(int quantity) {
    ViewModel.cartManager.insertProductInTheCart(_productToShow.name,
        _productToShow.type, _productToShow.supplier, quantity);
  }

  void modifyObservable() {
    ViewModel.observedProductManager.insertOrRemoveProduct(
        _productToShow.name,
        _productToShow.type,
        _productToShow.supplier,
        ViewModel.userDataManager.user.nickname,
        !_observed);
  }

  //Fare i relativi getter per far si che il widget possa leggere i dati del prodotto

  Product get product => _productToShow;
  bool get isObserved => _observed;
}
