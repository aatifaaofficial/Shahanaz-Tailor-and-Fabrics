import 'package:go_router/go_router.dart';

import '../../screens/about/about_screen.dart';
import '../../screens/admin/admin_dashboard_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/checkout/checkout_screen.dart';
import '../../screens/customization/custom_dress_designer_screen.dart';
import '../../screens/fabrics/fabric_details_screen.dart';
import '../../screens/fabrics/fabrics_screen.dart';
import '../../screens/favorites/favorites_screen.dart';
import '../../screens/help/help_support_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/home/main_navigation.dart';
import '../../screens/measurements/measurements_screen.dart';
import '../../screens/notifications/notifications_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/order_success/order_success_screen.dart';
import '../../screens/orders/order_details_screen.dart';
import '../../screens/orders/orders_screen.dart';
import '../../screens/product_details/product_details_screen.dart';
import '../../screens/products/products_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/splash/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/forgot-password', builder: (context, state) => const ForgotPasswordScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigation(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/shop', builder: (context, state) => const ProductsScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/customize', builder: (context, state) => const CustomDressDesignerScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/orders', builder: (context, state) => const OrdersScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
          ],
        ),
      ],
    ),
    GoRoute(path: '/products', builder: (context, state) => const ProductsScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return ProductDetailsScreen(productId: id);
      },
    ),
    GoRoute(
      path: '/product-details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return ProductDetailsScreen(productId: id);
      },
    ),
    GoRoute(path: '/fabrics', builder: (context, state) => const FabricsScreen()),
    GoRoute(
      path: '/fabric/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return FabricDetailsScreen(fabricId: id);
      },
    ),
    GoRoute(
      path: '/fabric-details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return FabricDetailsScreen(fabricId: id);
      },
    ),
    GoRoute(path: '/favorites', builder: (context, state) => const FavoritesScreen()),
    GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
    GoRoute(path: '/checkout', builder: (context, state) => const CheckoutScreen()),
    GoRoute(path: '/order-success', builder: (context, state) => const OrderSuccessScreen()),
    GoRoute(path: '/measurements', builder: (context, state) => const MeasurementsScreen()),
    GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
    GoRoute(path: '/edit-profile', builder: (context, state) => const EditProfileScreen()),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    GoRoute(path: '/help', builder: (context, state) => const HelpSupportScreen()),
    GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
    GoRoute(path: '/admin', builder: (context, state) => const AdminDashboardScreen()),
    GoRoute(path: '/order/:id', builder: (context, state) => OrderDetailsScreen(orderId: state.pathParameters['id'] ?? '')),
    GoRoute(path: '/order-details/:id', builder: (context, state) => OrderDetailsScreen(orderId: state.pathParameters['id'] ?? '')),
  ],
);
