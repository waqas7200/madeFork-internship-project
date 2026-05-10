import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> sendOtp(String phone) async {
  final url = Uri.parse('https://development.rapidit.in/api/otp/send');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "phone": phone,
      "role": "user"
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Success: ${data['message']}");
  } else {
    print("Error: ${response.body}");
  }
}



class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  void handleSendOtp() async {
    String phone = phoneController.text.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter phone number")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await sendOtp(phone);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> sendOtp(String phone) async {
    final url = Uri.parse('https://development.rapidit.in/api/otp/send');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "phone": phone,
          "role": "user"
        }),
      );

      final data = jsonDecode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? "Response received")),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : handleSendOtp,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}