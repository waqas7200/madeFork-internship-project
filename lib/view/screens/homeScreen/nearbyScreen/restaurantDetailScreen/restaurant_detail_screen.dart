import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../model/nerabyresturentModel/nearbyresturntModl.dart';
import '../../../../../model/rerecomandatomproductModel/recomandatioprouductModel.dart';
import '../../../../../model/restaurantProductModel/restaurant_product_model.dart';
import '../../../../utils/costsColors/constColors.dart';
import '../../../../utils/responsiveClass/responosiveC;ass.dart';
import '../../comandationscreen/productdetailscreen/productdetilscreen.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  List<RestaurantProductModel> products = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final response = await Supabase.instance.client
          .from('products')
          .select('*, product_images(image_url)')
          .eq('restaurant_id', widget.restaurant.id);

      final List<RestaurantProductModel> fetched = [];
      for (var item in response) {
        fetched.add(RestaurantProductModel.fromJson(item));
      }

      setState(() {
        products = fetched;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    APPResponsive().init(context);
    final restaurant = widget.restaurant;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          // ─── SLIVER APP BAR WITH RESTAURANT IMAGE ───
          SliverAppBar(
            expandedHeight: context.rH(28),
            pinned: true,
            backgroundColor: AppColor.backgroundBlue,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    restaurant.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColor.backgroundBlue,
                      child: const Icon(Icons.restaurant, size: 60, color: Colors.white70),
                    ),
                  ),
                  // Gradient overlay for readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Restaurant name on image
                  Positioned(
                    bottom: context.rH(2),
                    left: context.rW(4),
                    right: context.rW(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: APPResponsive.fs(5.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.person_outline, color: Colors.white70, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.ownerName,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: APPResponsive.fs(3),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── RESTAURANT INFO CARD ───
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(context.rW(4)),
              padding: EdgeInsets.all(context.rW(4)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location Row
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.red.shade400, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          restaurant.address,
                          style: TextStyle(
                            fontSize: APPResponsive.fs(3.2),
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.rH(1.2)),

                  // Distance & Rating Row
                  Row(
                    children: [
                      // Distance chip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.near_me, color: Colors.blue.shade700, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.distanceStr,
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: APPResponsive.fs(2.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Rating chip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber.shade700, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.rating,
                              style: TextStyle(
                                color: Colors.amber.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: APPResponsive.fs(2.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.rH(1.2)),

                  // Description
                  if (restaurant.description.isNotEmpty) ...[
                    Divider(color: Colors.grey.shade200),
                    SizedBox(height: context.rH(0.5)),
                    Text(
                      restaurant.description,
                      style: TextStyle(
                        fontSize: APPResponsive.fs(3),
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // ─── PRODUCTS HEADER ───
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
              child: Row(
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: APPResponsive.fs(4.5),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!isLoading)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColor.backgroundBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${products.length}',
                        style: TextStyle(
                          fontSize: APPResponsive.fs(2.8),
                          color: AppColor.backgroundBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: context.rH(1.5))),

          // ─── PRODUCTS LIST ───
          if (isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (errorMessage.isNotEmpty)
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
                ),
              ),
            )
          else if (products.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu, size: 60, color: Colors.grey.shade300),
                    const SizedBox(height: 12),
                    Text(
                      'No products available yet.',
                      style: TextStyle(color: Colors.grey.shade500, fontSize: APPResponsive.fs(3.5)),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = products[index];
                    return _ProductCard(
                      product: product,
                      storeName: widget.restaurant.name,
                      restaurantId: widget.restaurant.id,
                    );
                  },
                  childCount: products.length,
                ),
              ),
            ),

          // Bottom spacing
          SliverToBoxAdapter(child: SizedBox(height: context.rH(4))),
        ],
      ),
    );
  }
}

// ─── PRODUCT CARD WIDGET ───
class _ProductCard extends StatelessWidget {
  final RestaurantProductModel product;
  final String storeName;
  final String restaurantId;

  const _ProductCard({
    required this.product,
    required this.storeName,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        final productDetail = Product(
          id: product.id,
          name: product.title,
          store: storeName,
          restaurantId: restaurantId,
          price: '₱${product.total.toStringAsFixed(2)}',
          image: product.image,
          description: product.description,
          sizes: [],
          rating: product.rating,
          reviews: 0,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: productDetail),
          ),
        );
      },
      child: Container(
      margin: EdgeInsets.only(bottom: context.rH(1.5)),
      padding: EdgeInsets.all(context.rW(3.5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product info (left side)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: APPResponsive.fs(3.5),
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: context.rH(0.5)),

                // Description
                if (product.description.isNotEmpty)
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: APPResponsive.fs(2.8),
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(height: context.rH(1)),

                // Price row
                Row(
                  children: [
                    // Final price
                    Text(
                      '₱${product.total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: APPResponsive.fs(3.5),
                        fontWeight: FontWeight.bold,
                        color: AppColor.backgroundBlue,
                      ),
                    ),

                    // Original price (show if on sale)
                    if (product.isSale && product.discount > 0) ...[
                      const SizedBox(width: 8),
                      Text(
                        '₱${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: APPResponsive.fs(2.8),
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '-₱${product.discount.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: APPResponsive.fs(2.3),
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: context.rH(0.8)),

                // Rating & availability
                Row(
                  children: [
                    if (product.rating > 0) ...[
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: APPResponsive.fs(2.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: product.availability ? Colors.green.shade50 : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        product.availability ? 'Available' : 'Unavailable',
                        style: TextStyle(
                          fontSize: APPResponsive.fs(2.3),
                          color: product.availability ? Colors.green.shade700 : Colors.red.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Product Image (Right side)
          SizedBox(width: context.rW(3)),
          Container(
            width: context.rW(22),
            height: context.rW(22),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product.image.isNotEmpty
                  ? Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.fastfood, color: Colors.grey.shade400, size: context.rW(8)),
                    )
                  : Icon(Icons.fastfood, color: Colors.grey.shade400, size: context.rW(8)),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
