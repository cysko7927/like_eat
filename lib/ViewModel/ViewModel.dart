import 'package:like_eat/Model/User.dart';
import 'package:like_eat/ViewModel/CartManager.dart';
import 'package:like_eat/ViewModel/HistoryManager.dart';
import 'package:like_eat/ViewModel/NotificationManager.dart';
import 'package:like_eat/ViewModel/ProductManager.dart';
import 'package:like_eat/ViewModel/SearchManager.dart';
import 'package:like_eat/ViewModel/UserDataManager.dart';

/**
 * This class contains all the component of the view-model
 */
class ViewModel {
  static CartManager cartManager;
  static HistoryManager historyManager;
  static NotificationManager notificationManager;
  static ProductManager productManager;
  static SearchManager searchManager;
  static UserDataManager userDataManager;
}
