// ─────────────────────────────────────────────
//  APP ROUTE CONSTANTS
//  Sab route names yahan define hain.
//  Navigation ke liye sirf in constants ko use karo.
// ─────────────────────────────────────────────

class AppRoutes {
  AppRoutes._(); // Private constructor — instantiate mat karo

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';

  static const String main = '/main'; // BottomNav MainScreen
  static const String home = '/home';
  static const String myOrder = '/my-order';
  static const String nearbyAll = '/nearby-all'; // NearByMerchantScreen

  static const String productDetail = '/product-detail';
  static const String restaurantDetail = '/restaurant-detail';
  static const String category = '/category';

  static const String checkout = '/checkout';
  static const String payment = '/payment';
  static const String filter = '/filter';
  static const String trackOrder = '/track-order';
  static const String orderHistory = '/order-history';
}
