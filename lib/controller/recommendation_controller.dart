import 'dart:math';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/rerecomandatomproductModel/recomandatioprouductModel.dart';

class RecommendationController extends GetxController {
  var recommendedProducts = <Product>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final supabase = Supabase.instance.client;
      // 1. Fetch products
      final productsRes = await supabase.from('products').select();

      if (productsRes.isEmpty) {
        recommendedProducts.value = [];
        return;
      }

      // 2. Fetch product images
      final imagesRes = await supabase
          .from('product_images')
          .select('product_id, image_url');
      final imageMap = <String, String>{};
      for (var img in imagesRes) {
        final pId = img['product_id']?.toString();
        final url = img['image_url']?.toString();
        if (pId != null && url != null && !imageMap.containsKey(pId)) {
          imageMap[pId] = url; // take first image
        }
      }

      // 3. Fetch restaurants for shop_name
      final restaurantIds = productsRes
          .map((p) => p['restaurant_id']?.toString())
          .whereType<String>()
          .toSet()
          .toList();
      final restaurantsRes = restaurantIds.isNotEmpty
          ? await supabase
                .from('restaurants')
                .select('id, shop_name')
                .inFilter('id', restaurantIds)
          : [];

      final restaurantMap = <String, String>{};
      for (var r in restaurantsRes) {
        final rId = r['id']?.toString();
        if (rId != null) {
          restaurantMap[rId] = r['shop_name']?.toString() ?? 'Restaurant';
        }
      }

      final random = Random();
      final tempProducts = <Product>[];

      for (var p in productsRes) {
        final pId = p['id']?.toString() ?? '';
        final rId = p['restaurant_id']?.toString() ?? '';

        final priceVal = double.tryParse(p['price']?.toString() ?? '0') ?? 0.0;
        final priceStr = '₱${priceVal.toStringAsFixed(2)}';

        // Generate random rating between 3.5 and 5.0
        final randomRating = 3.5 + random.nextDouble() * 1.5;
        final randomReviews = 50 + random.nextInt(400);

        tempProducts.add(
          Product(
            id: pId,
            name: p['title']?.toString() ?? 'Product',
            store: restaurantMap[rId] ?? 'Unknown Restaurant',
            restaurantId: rId,
            price: priceStr,
            image: imageMap[pId] ?? 'https://via.placeholder.com/300',
            description: p['description']?.toString() ?? '',
            sizes:
                [], // Empty list will trigger default S, M, L, XL in ProductDetailScreen
            rating: double.parse(randomRating.toStringAsFixed(1)),
            reviews: randomReviews,
          ),
        );
      }

      // 4. Sort by rating descending (highest first)
      tempProducts.sort((a, b) => b.rating.compareTo(a.rating));

      // Show top 10 items in recommendations
      recommendedProducts.value = tempProducts.take(10).toList();
    } catch (e) {
      errorMessage.value = 'Failed to load recommendations: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
