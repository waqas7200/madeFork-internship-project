import 'package:flutter/material.dart';
import 'package:madeforke_app/view/screens/alloferscreen/vochercard/vochercard.dart';
import 'package:madeforke_app/view/screens/alloferscreen/vocherlist/vocherlist.dart';
import '../../../model/vochermodel/vochermodel.dart';


class AllOfferScreen extends StatelessWidget {

  const AllOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,

      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("All Offer", style: TextStyle(color: Colors.black)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart, color: Colors.black),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔥 Top Banner
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.teal],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      "Make Your First\n Order Here\n 23",
                      style: TextStyle(color: Colors.white, fontSize: 18,
                      fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Image(image: AssetImage('assets/splash_Icon/Logo.png'))
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔥 Discount Banner
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Discount 50",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          "50% All Asian Foodie",
                          style: TextStyle(color: Colors.white, fontSize: 20,
                          fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Vouchers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            // 🔽 Voucher List
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
                (crossAxisCount: 2,
              crossAxisSpacing: 10
              ),

              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: VoucherData.vouchers.length,
              itemBuilder: (context, index) {
                return VoucherCard(
                  voucher: VoucherData.vouchers[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}