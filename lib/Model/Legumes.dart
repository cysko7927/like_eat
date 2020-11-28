import 'package:like_eat/Model/Product.dart';

class Legumes extends Product {
  bool _read;
  Legumes(supplier, type, name, price, quantity, this._read)
      : super(supplier, type, name, price, quantity);

  bool get readGet => _read;
  set readSet(bool value) => _read = value;
}
