
// ─────────────────────────────────────────────
//  NEARBY LIST
// ─────────────────────────────────────────────
import 'package:flutter/cupertino.dart';

import '../../../component/customNearby/customNearby.dart';
import '../../bottomNavigationBar/bottomNavgationBar.dart';

class NearbyList extends StatelessWidget {
  const NearbyList({super.key});

  static const List<Map<String, String>> _items = [
    {
      'name': 'Starbucks',
      'address': 'Alaminos, Pang',
      'distance': '18 km',
      'rating': '4.5',
      'image': 'https://images.unsplash.com/photo-1601314212543-b0e2eabe3a0e?w=200',
    },
    {
      'name': 'OwlEnergy',
      'address': 'Dagupan, Pang',
      'distance': '12 km',
      'rating': '4.2',
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=200',
    },
    {
      'name': 'NiceeCire',
      'address': 'Dagupan, Pang',
      'distance': '12 km',
      'rating': '4.7',
      'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=200',
    },
    {
      'name': 'BurgerZone',
      'address': 'Lingayen, Pang',
      'distance': '8 km',
      'rating': '4.3',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: context.rW(4)),
      itemCount: _items.length,
      separatorBuilder: (_, __) => SizedBox(height: context.rH(1.2)),
      itemBuilder: (context, i) => NearbyCard(item: _items[i]),
    );
  }
}
