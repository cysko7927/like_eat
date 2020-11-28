import 'package:like_eat/Model/Notification.dart';
import 'package:like_eat/Model/Product.dart';

class Discount extends Notification {
  double _percentage;
  bool _stillActive;
  Discount(Product referenceProduct) : super(referenceProduct);

  double get percentageGet => _percentage;
  set percentageSet(double percentage) => _percentage = percentage;

  bool get stillActiveGet => _stillActive;
  set stillActiveSet(bool value) => _stillActive = value;

  change() {
    if (this._stillActive == true)
      this._stillActive = false;
    else
      this._stillActive = true;
  }
}
