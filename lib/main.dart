import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madeforke_app/view/screens/bottomNavigationBar/bottomNavgationBar.dart';
import 'package:madeforke_app/view/screens/splashScreen/splashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controller/auth_Cntroller/auth_Controller.dart';
import 'utils/app_routes.dart';
import 'view/screens/auth_screens/login_screen/Login_scren.dart';
import 'view/screens/auth_screens/registerScreen/reisterScreen.dart';
import 'view/screens/auth_screens/forgeScreen/forgetpasword_screen.dart';
import 'view/screens/auth_screens/otpSreen/otp_screen.dart';
import 'view/screens/onbordingScreens/onbordingScreens.dart';
import 'view/screens/homeScreen/HomeScreen.dart';
import 'view/screens/homeScreen/myorderScreenCart/myOrderCart.dart';
import 'view/screens/homeScreen/nearbyScreen/nearbymerhentscreen/nearbymerchentscren.dart';
import 'view/screens/homeScreen/comandationscreen/productdetailscreen/productdetilscreen.dart';
import 'view/screens/homeScreen/nearbyScreen/restaurantDetailScreen/restaurant_detail_screen.dart';
import 'view/screens/homeScreen/catageryscreen/catageryscreene.dart';
import 'view/screens/checkoutscreen/checkoutscreen.dart';
import 'view/screens/paymentscreen/paymentscreen.dart';
import 'view/screens/filterscrren/filtrscreen.dart';
import 'view/screens/trackingorderscreen/trackingorderscreen.dart';
import 'view/screens/orderhistoryscreen/order_history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://omwgprcqjxyostiauhfm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9td2dwcmNxanh5b3N0aWF1aGZtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg5ODgyODksImV4cCI6MjA5NDU2NDI4OX0.DitT6zikMHeTlJBJzw15Sl6ren6AN_NkK8_rlETPGZ0',
  );
  runApp(const MyApp());
  Get.put(AuthController());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: [
        // ── Auth Flow ──────────────────────────────────────────────
        GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
        GetPage(
          name: AppRoutes.onboarding,
          page: () => const OnboardingScreen(),
        ),
        GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
        GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
        GetPage(
          name: AppRoutes.forgotPassword,
          page: () => const ForgetPasswordScreen(),
        ),
        // OTP: pass email string via Get.arguments
        GetPage(
          name: AppRoutes.otp,
          page: () => OtpScreen(email: Get.arguments as String? ?? ''),
        ),

        // ── Main / Home ────────────────────────────────────────────
        GetPage(name: AppRoutes.main, page: () => const MainScreen()),
        GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
        GetPage(name: AppRoutes.myOrder, page: () => MyOrderScreen()),
        GetPage(
          name: AppRoutes.nearbyAll,
          page: () => const NearByMerchantScreen(),
        ),
        GetPage(name: AppRoutes.category, page: () => CatagerytScreen()),
        GetPage(name: AppRoutes.filter, page: () => FilterScreen()),
        GetPage(name: AppRoutes.trackOrder, page: () => TrackOrderScreen()),
        GetPage(
          name: AppRoutes.orderHistory,
          page: () => UserOrderHistoryScreen(),
        ),

        // ── Detail Screens (require arguments) ────────────────────
        // ProductDetail: arguments = Product object
        GetPage(
          name: AppRoutes.productDetail,
          page: () => ProductDetailScreen(product: Get.arguments),
        ),
        // RestaurantDetail: arguments = RestaurantModel object
        GetPage(
          name: AppRoutes.restaurantDetail,
          page: () => RestaurantDetailScreen(restaurant: Get.arguments),
        ),

        // ── Order Flow ─────────────────────────────────────────────
        // Checkout: arguments = Map<String,dynamic> {subtotal, deliveryFee, total}
        GetPage(
          name: AppRoutes.checkout,
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return CheckoutScreen(
              subtotal: (args['subtotal'] as num).toDouble(),
              deliveryFee: (args['deliveryFee'] as num).toDouble(),
              total: (args['total'] as num).toDouble(),
            );
          },
        ),
        // Payment: arguments = Map<String,dynamic> (all optional)
        GetPage(
          name: AppRoutes.payment,
          page: () {
            final args = (Get.arguments as Map<String, dynamic>?) ?? {};
            return PaymentMethodScreen(
              isFromCheckout: args['isFromCheckout'] as bool? ?? false,
              subtotal: (args['subtotal'] as num?)?.toDouble() ?? 0.0,
              deliveryFee: (args['deliveryFee'] as num?)?.toDouble() ?? 0.0,
              total: (args['total'] as num?)?.toDouble() ?? 0.0,
              deliveryAddress: args['deliveryAddress'] as String? ?? '',
            );
          },
        ),
      ],
    );
  }
}
