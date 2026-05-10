import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔝 AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Track",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=3"),
            ),
          )
        ],
      ),

      body: Stack(
        children: [

          // 🗺️ Fake Map Background
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              "https://i.imgur.com/ZXBtVw7.png", // dummy map image
              fit: BoxFit.cover,
            ),
          ),

          // 📍 Center Location Pin
          Center(
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 📦 Bottom Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
             // height: 300,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  // 🔘 Handle
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // 📍 Location Info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.star,
                              color: Colors.orange, size: 18),
                          Container(
                            height: 30,
                            width: 2,
                            color: Colors.orange,
                          ),
                          Icon(Icons.star,
                              color: Colors.orange, size: 18),
                          Container(
                            height: 30,
                            width: 2,
                            color: Colors.orange,
                          ),
                          Icon(Icons.star,
                              color: Colors.grey, size: 18),
                        ],
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Cricket Ground Bld",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "8101 S Kenwood Ave, Chicago, IL",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Courier ||",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Delevering",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Home",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "8000 S Kirkland Ave, Chicago",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 16),
                  Text("Order Tracking ",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                      fontSize: 17)),
                  const SizedBox(height: 16),
                  // 🚚 Courier Info
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            "https://i.pravatar.cc/150?img=5"),
                      ),
                      const SizedBox(width: 10),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text("Jordan Edwards",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold)),
                            Text("Courier",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey)),
                          ],
                        ),
                      ),



                      // 💬 Message Button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.message,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // 📞 Call Button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.call,
                              color: Colors.white),
                        ),
                      ),


                    ],
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}