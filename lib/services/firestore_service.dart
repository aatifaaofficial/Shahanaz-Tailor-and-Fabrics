import '../core/constants/app_constants.dart';

class FirestoreService {
  static const bool isConfigured = false;

  static String get usersCollection => AppConstants.firebaseCollectionsUsers;
  static String get productsCollection => AppConstants.firebaseCollectionsProducts;
  static String get categoriesCollection => AppConstants.firebaseCollectionsCategories;
  static String get fabricsCollection => AppConstants.firebaseCollectionsFabrics;
  static String get ordersCollection => AppConstants.firebaseCollectionsOrders;
  static String get customOrdersCollection => AppConstants.firebaseCollectionsCustomOrders;
  static String get measurementsCollection => AppConstants.firebaseCollectionsMeasurements;
  static String get favoritesCollection => AppConstants.firebaseCollectionsFavorites;
  static String get reviewsCollection => AppConstants.firebaseCollectionsReviews;
  static String get notificationsCollection => AppConstants.firebaseCollectionsNotifications;
}
