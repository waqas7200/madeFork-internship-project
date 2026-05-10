import 'package:flutter/material.dart';
import 'package:madeforke_app/view/utils/costsColors/constColors.dart';

import '../../../model/paymentmodel/paymentmodel.dart';
import '../../component/customCircleAvator/customCircleavators.dart';
import '../bottomNavigationBar/bottomNavgationBar.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // Mock Data mimicking API Response
  final List<Map<String, dynamic>> rawCards = [
    {'cardNumber': '7741 6588 2123 6644', 'holderName': 'JORDAN WATSON', 'cardColor': '0xFF2D3436', 'brand': 'VISA'},
    {'cardNumber': '3341 6888 1234 5678', 'holderName': 'JORDAN BLACK', 'cardColor': '0xFF00897B', 'brand': 'VISA'},
  ];

  final List<Map<String, dynamic>> rawOptions = [
    {'title': 'Pay', 'balance': 'Balance: \$1,340', 'iconCode': 0xf04ee}, // Apple icon code
    {'title': 'PayPal', 'balance': 'Balance: \$3,341', 'iconCode': 0xf04eb}, // Payment icon code
    {'title': 'GCash', 'balance': 'Balance: \$5,334', 'iconCode': 0xef3e},  // Wallet icon code
  ];

  late List<CreditCardModel> cardList;
  late List<PaymentOptionModel> optionList;
  String selectedMethod = "Apple Pay";

  @override
  void initState() {
    super.initState();
    // Converting Maps to Models using Factory
    cardList = rawCards.map((m) => CreditCardModel.fromMap(m)).toList();
    optionList = rawOptions.map((m) => PaymentOptionModel.fromMap(m)).toList();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryYellow = Color(0xFFF5A623);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor:AppColor.backgroundYellow,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: context.rH(10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            _circleBtn(Icons.arrow_back),
            const Text("Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                const Icon(Icons.shopping_cart_outlined),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(color: Colors.white, height: 35, width: 35,
                      child: const Icon(Icons.person)),
                ),
              ],
            ),
          ],
        ),

      ),
      body: Stack(
        children: [
          Positioned(
            top: -490,
            right: -95,
            child: BackgroundCircle(size:600, color: AppColor.backgroundYellow),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              children: [
                const SizedBox(height: 20),
                _buildSectionTitle("Credit Cards", showAdd: true),

                // Horizontal Cards
                SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cardList.length,
                    itemBuilder: (context, index) => _cardWidget(cardList[index]),
                  ),
                ),

                const SizedBox(height: 30),
                _buildSectionTitle("Other option"),
                const SizedBox(height: 15),

                // Options List
                ...optionList.map((opt) => _optionWidget(opt)).toList(),
              ],
            ),
          ),
        ],
      ),

    );
  }

  // --- UI Components ---



  // Widget _cardWidget(CreditCardModel card) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       width: 320,
  //       margin: const EdgeInsets.only(right: 5),
  //       padding: const EdgeInsets.all(20),
  //       decoration: BoxDecoration(
  //         color: card.cardColor,
  //         borderRadius: BorderRadius.circular(25),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(card.brand, style: const TextStyle(color: Colors.white, fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //               fontStyle: FontStyle.italic, //
  //               //italic: true
  //           )),
  //           Text(card.cardNumber, style: const TextStyle(color: Colors.white,
  //               fontSize: 16, letterSpacing: 1.5)),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(card.holderName, style: const TextStyle(color: Colors.white70, fontSize: 11)),
  //               const Icon(Icons.contactless, color: Colors.white, size: 24),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _cardWidget(CreditCardModel card) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 320,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: card.cardColor,
          borderRadius: BorderRadius.circular(25),
        ),
        // Stack use kar rahe hain taaki circles background mein jayen
        child: Stack(
          children: [
            // 1. Left Side Circle (Halka grey, Visa ke niche)
            Positioned(
              top: -10,
              left: -25,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white.withOpacity(0.05), // Boht halka grey/white effect
              ),
            ),

            // 2. Bottom Right Circle (Sirf Border/Lines wala)
            Positioned(
              bottom: 20,
              right: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1), // Halka grey line effect
                    width: 5,
                  ),
                ),
              ),
            ),

            // Main Content (Jo pehle se tha)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card.brand,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    card.cardNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card.holderName,
                        style: const TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                      const Icon(Icons.contactless, color: Colors.white, size: 24),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _optionWidget(PaymentOptionModel opt) {
    bool isSelected = selectedMethod == opt.title;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = opt.title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isSelected ? const Color(0xFFF5A623) : Colors.transparent),
        ),
        child: ListTile(
          leading: Icon(opt.icon, size: 30, color: Colors.blueGrey),
          title: Text(opt.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Text(opt.balance, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: Radio<String>(
            value: opt.title,
            groupValue: selectedMethod,
            activeColor: const Color(0xFFF5A623),
            onChanged: (v) => setState(() => selectedMethod = v!),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showAdd = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,),
            child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          if (showAdd) Padding(
            padding: const EdgeInsets.only(right: 40),
            child: CircleAvatar(
                backgroundColor:AppColor.backgroundBlue ,
                child: const Icon(Icons.add, color: Colors.white,size: 35,)),
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, size: 20, color: Colors.black),
    );
  }




}