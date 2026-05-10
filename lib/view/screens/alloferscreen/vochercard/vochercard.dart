import 'package:flutter/material.dart';
import '../../../../model/vochermodel/vochermodel.dart';


class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  const VoucherCard({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
       // const Icon(Icons.card_giftcard, color: Colors.orange),
         // const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(voucher.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
                Text(voucher.subtitle,
                    style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),

          Text(voucher.discount, style: const TextStyle(fontSize: 38)),
        ],
      ),
    );
  }
}