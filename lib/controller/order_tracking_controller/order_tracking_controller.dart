// ─────────────────────────────────────────────
//  ORDER TRACKING CONTROLLER
// ─────────────────────────────────────────────
import 'dart:async';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/order_tracking_model/order_tracking_model.dart';

class OrderTrackingController extends GetxController {
  final _supabase = Supabase.instance.client;

  // ── State ──────────────────────────────────────────────────────────
  var orders = <OrderTrackingModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  // Active detail order (for detail screen real-time)
  var activeOrder = Rxn<OrderTrackingModel>();
  StreamSubscription<List<Map<String, dynamic>>>? _realtimeSub;

  // ── Lifecycle ──────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  @override
  void onClose() {
    _realtimeSub?.cancel();
    super.onClose();
  }

  // ── Fetch all orders for current user ─────────────────────────────
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        errorMessage.value = 'Please log in to view orders.';
        return;
      }

      // 1. Fetch user orders
      final List<dynamic> ordersResponse = await _supabase
          .from('orders')
          .select('''
            id, restaurant_id, address, total_amount, status, order_stage,
            payment_method, created_at, updated_at
          ''')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      if (ordersResponse.isEmpty) {
        orders.value = [];
        return;
      }

      final orderIds = ordersResponse
          .map((o) => o['id']?.toString())
          .whereType<String>()
          .toList();
      final restaurantIds = ordersResponse
          .map((o) => o['restaurant_id']?.toString())
          .whereType<String>()
          .toSet()
          .toList();

      // 2. Fetch order items
      final List<dynamic> orderItemsResponse = await _supabase
          .from('order_items')
          .select('order_id, product_id, quantity, price')
          .inFilter('order_id', orderIds);

      final productIds = orderItemsResponse
          .map((oi) => oi['product_id']?.toString())
          .whereType<String>()
          .toSet()
          .toList();

      // 3. Fetch restaurants
      final List<dynamic> restaurantsResponse = restaurantIds.isNotEmpty
          ? await _supabase
                .from('restaurants')
                .select('id, shop_name')
                .inFilter('id', restaurantIds)
          : [];

      // 4. Fetch products
      final List<dynamic> productsResponse = productIds.isNotEmpty
          ? await _supabase
                .from('products')
                .select('id, title')
                .inFilter('id', productIds)
          : [];

      // Create lookup maps
      final restaurantMap = {
        for (var r in restaurantsResponse)
          r['id']?.toString(): {
            'name': r['shop_name']?.toString() ?? 'Restaurant',
          },
      };
      final productMap = {
        for (var p in productsResponse)
          p['id']?.toString(): {'name': p['title']?.toString() ?? 'Item'},
      };

      // Group order items by order_id
      final orderItemsGrouped = <String, List<Map<String, dynamic>>>{};
      for (var oi in orderItemsResponse) {
        final orderId = oi['order_id']?.toString();
        if (orderId != null) {
          final prodId = oi['product_id']?.toString();
          final prodData = productMap[prodId] ?? {'name': 'Item'};

          final oiMap = {
            'product_id': prodId,
            'quantity': oi['quantity'],
            'price': oi['price'],
            'products': prodData,
          };
          orderItemsGrouped.putIfAbsent(orderId, () => []).add(oiMap);
        }
      }

      // Assemble final data structure
      final assembled = ordersResponse.map((o) {
        final orderId = o['id']?.toString() ?? '';
        final restId = o['restaurant_id']?.toString();
        final restData = restaurantMap[restId] ?? {'name': 'Restaurant'};
        final itemsData = orderItemsGrouped[orderId] ?? [];

        return {
          ...o as Map<String, dynamic>,
          'restaurants': restData,
          'order_items': itemsData,
        };
      }).toList();

      orders.value = assembled
          .map((e) => OrderTrackingModel.fromMap(e))
          .toList();
    } catch (e) {
      errorMessage.value = 'Failed to load orders: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // ── Subscribe to real-time updates for a specific order ──────────
  void subscribeToOrder(String orderId) {
    _realtimeSub?.cancel();

    _realtimeSub = _supabase
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('id', orderId)
        .listen((rows) async {
          if (rows.isEmpty) return;

          try {
            final orderData = rows.first;
            final restId = orderData['restaurant_id']?.toString();

            // Fetch order items
            final List<dynamic> orderItemsResponse = await _supabase
                .from('order_items')
                .select('order_id, product_id, quantity, price')
                .eq('order_id', orderId);

            final productIds = orderItemsResponse
                .map((oi) => oi['product_id']?.toString())
                .whereType<String>()
                .toSet()
                .toList();

            // Fetch restaurant name
            final restResponse = restId != null
                ? await _supabase
                      .from('restaurants')
                      .select('shop_name')
                      .eq('id', restId)
                      .maybeSingle()
                : null;

            // Fetch products
            final List<dynamic> productsResponse = productIds.isNotEmpty
                ? await _supabase
                      .from('products')
                      .select('id, title')
                      .inFilter('id', productIds)
                : [];

            final productMap = {
              for (var p in productsResponse)
                p['id']?.toString(): {'name': p['title']?.toString() ?? 'Item'},
            };

            final itemsData = orderItemsResponse.map((oi) {
              final prodId = oi['product_id']?.toString();
              final prodData = productMap[prodId] ?? {'name': 'Item'};
              return {
                'product_id': prodId,
                'quantity': oi['quantity'],
                'price': oi['price'],
                'products': prodData,
              };
            }).toList();

            final restData = restResponse != null
                ? {
                    'name':
                        restResponse['shop_name']?.toString() ?? 'Restaurant',
                  }
                : {'name': 'Restaurant'};

            final assembled = {
              ...orderData,
              'restaurants': restData,
              'order_items': itemsData,
            };

            activeOrder.value = OrderTrackingModel.fromMap(assembled);
            // Also update in the main list
            final idx = orders.indexWhere((o) => o.id == orderId);
            if (idx != -1) {
              orders[idx] = activeOrder.value!;
              orders.refresh();
            }
          } catch (_) {}
        });
  }

  void cancelOrderSubscription() {
    _realtimeSub?.cancel();
    _realtimeSub = null;
    activeOrder.value = null;
  }

  // ── Submit Review ──────────────────────────────────────────────────
  Future<bool> submitReview({
    required String orderId,
    required String restaurantId,
    required int rating,
    required String comment,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      await _supabase.from('reviews').insert({
        'order_id': orderId,
        'restaurant_id': restaurantId,
        'user_id': userId,
        'rating': rating,
        'comment': comment.trim(),
        'created_at': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // ── Check if user already reviewed this order ──────────────────────
  Future<bool> hasAlreadyReviewed(String orderId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final res = await _supabase
          .from('reviews')
          .select('id')
          .eq('order_id', orderId)
          .eq('user_id', userId)
          .maybeSingle();
      return res != null;
    } catch (_) {
      return false;
    }
  }
}
