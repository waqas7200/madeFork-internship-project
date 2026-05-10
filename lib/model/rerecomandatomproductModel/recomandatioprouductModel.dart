// ─────────────────────────────────────────────
//  PRODUCT MODEL
// ─────────────────────────────────────────────

class Product {
  final String id;
  final String name;
  final String store;
  final String price;
  final String image;
  final String description;
  final List<String> sizes;
  final double rating;
  final int reviews;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.store,
    required this.price,
    required this.image,
    required this.description,
    required this.sizes,
    required this.rating,
    required this.reviews,
    this.isFavorite = false,
  });

  // Sample products data
  static List<Product> sampleProducts = [
    Product(
      id: '1',
      name: 'Kiwi Shake II',
      store: "McDonald's",
      price: '₱98.00',
      image: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=300',
      description: "wefskjxnieskjd sdhcjhew8i23wds shjkclhq3iwesdnckea jkshdc3iewhdkxncie sfdckesdciefdscnx"
          "jsfcuehfdciiejdsxcnjskdhciuekjdsx jdcjxkfhhhfksh8es jhufhxkjhehskdjh",
      sizes: ['32 oz', '48 oz', '59 oz', '64 oz', '96 oz'],
      rating: 4.5,
      reviews: 234,
    ),
    Product(
      id: '2',
      name: 'Blueberry Maze',
      store: "McDonald's",
      price: '₱98.00',
      image: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=300',
      description: 'بلیو بیری کا لذیذ مشروب جو آپ کو گرم موسم میں ٹھنڈا رکھے گا۔',
      sizes: ['32 oz', '48 oz', '59 oz', '64 oz', '96 oz'],
      rating: 4.3,
      reviews: 189,
    ),
    Product(
      id: '3',
      name: 'Pats Burger',
      store: "Starbucks",
      price: '₱134.00',
      image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300',
      description: 'Pats Burger ایک شاندار اور مزیدار برگر ہے جو ہمارے باورچی خانہ سے براہ راست تیار ہے۔',
      sizes: ['Small', 'Medium', 'Large'],
      rating: 4.7,
      reviews: 412,
    ),
    Product(
      id: '4',
      name: 'Berries Yogurt',
      store: "McDonald's",
      price: '₱98.00',
      image: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=300',
      description: 'صحت مند اور لذیذ بیری یوگرٹ جو آپ کی صحت کے لیے بہت اچھی ہے۔',
      sizes: ['150g', '200g', '300g', '500g'],
      rating: 4.4,
      reviews: 321,
    ),
  ];
}