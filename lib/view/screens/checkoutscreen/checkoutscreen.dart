import 'package:flutter/material.dart';
import 'package:madeforke_app/view/utils/costsColors/constColors.dart';
import '../../../model/addtocartmodel/addtocarmodel.dart';
import '../../utils/responsiveClass/responosiveC;ass.dart';
import '../homeScreen/myorderScreenCart/myOrderCart.dart';
import '../paymentscreen/paymentscreen.dart';

class CheckoutScreen extends StatefulWidget {
  final double subtotal;
  final double deliveryFee;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String deliveryMethod = "Standard"; // Standard / Express
  String selectedAddress = "8000 S Kirkland Ave, Chicago, IL";
  String addressTitle = "Home";

  @override
  Widget build(BuildContext context) {
    APPResponsive().init(context);
    
    // Calculate final total based on delivery method
    double currentDeliveryFee = deliveryMethod == "Express" ? widget.deliveryFee + 20.0 : widget.deliveryFee;
    double finalTotal = widget.subtotal + currentDeliveryFee;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.rW(4), vertical: context.rH(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── DELIVERY ADDRESS SECTION ──
            const Text(
              "Delivery Address",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.backgroundYellow.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.location_on, color: AppColor.backgroundYellow, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addressTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          selectedAddress,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_location_alt_rounded, color: AppColor.backgroundBlue),
                    onPressed: () {
                      // Custom dialog to edit address for premium feel
                      _showEditAddressDialog();
                    },
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── DELIVERY METHOD SECTION ──
            const Text(
              "Delivery Method",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildDeliveryMethodCard("Standard", "30-45 mins", widget.deliveryFee, Icons.delivery_dining_rounded),
                const SizedBox(width: 12),
                _buildDeliveryMethodCard("Express", "15-20 mins", widget.deliveryFee + 20.0, Icons.bolt_rounded),
              ],
            ),

            const SizedBox(height: 24),

            // ── ORDER ITEMS PREVIEW ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order Items",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                Text(
                  "${cartItems.length} items",
                  style: TextStyle(fontSize: 13, color: AppColor.backgroundBlue, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                separatorBuilder: (_, __) => Divider(color: Colors.grey.shade100, height: 16),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey.shade100,
                            child: const Icon(Icons.image_not_supported, size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Size: ${item.size}  •  Qty: ${item.quantity}",
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        item.price,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColor.backgroundBlue),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // ── ORDER SUMMARY ──
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  _buildSummaryRow("Subtotal", "₱${widget.subtotal.toStringAsFixed(2)}"),
                  const SizedBox(height: 10),
                  _buildSummaryRow("Delivery Fee", "₱${currentDeliveryFee.toStringAsFixed(2)}"),
                  Divider(color: Colors.grey.shade100, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                      ),
                      Text(
                        "₱${finalTotal.toStringAsFixed(2)}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.backgroundBlue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(context.rW(4), context.rH(1.5), context.rW(4), context.rH(3.5)),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to Payment Method Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentMethodScreen(
                    isFromCheckout: true,
                    subtotal: widget.subtotal,
                    deliveryFee: currentDeliveryFee,
                    total: finalTotal,
                    deliveryAddress: selectedAddress,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.backgroundBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Proceed to Payment",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryMethodCard(String method, String time, double price, IconData icon) {
    bool isSelected = deliveryMethod == method;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            deliveryMethod = method;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.backgroundBlue.withOpacity(0.05) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppColor.backgroundBlue : Colors.grey.shade200,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? AppColor.backgroundBlue : Colors.grey, size: 24),
              const SizedBox(height: 8),
              Text(
                method,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: isSelected ? AppColor.backgroundBlue : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 6),
              Text(
                "₱${price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: isSelected ? AppColor.backgroundBlue : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }

  void _showEditAddressDialog() {
    final TextEditingController addressCtrl = TextEditingController(text: selectedAddress);
    final TextEditingController titleCtrl = TextEditingController(text: addressTitle);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Update Delivery Address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: "Label (e.g., Home, Work)",
                hintText: "Enter label",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                labelText: "Address",
                hintText: "Enter full address",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (addressCtrl.text.isNotEmpty && titleCtrl.text.isNotEmpty) {
                setState(() {
                  selectedAddress = addressCtrl.text;
                  addressTitle = titleCtrl.text;
                });
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.backgroundBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
