import 'package:like_eat/Model/Product.dart';

class Vegetables extends Product {
  bool _read;
  Vegetables(supplier, type, name, price, quantity, this._read)
      : super(supplier, type, name, price, quantity);

  //Getter
  bool get read => _read;

  //Setter
  set read(bool value) => _read = value;
}
