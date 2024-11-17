import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://www.cityworksrestaurant.com/wp-content/uploads/2021/11/CW.Pittsburgh.040-1024x683.jpg', // replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
          // Overlay with Restaurant Details
          Positioned(
            top: 80.0, // Adjust the top position
            left: 20.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Title and Rating
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Restaurant Title',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '4.5 ★★★★☆',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'XX Miles Away',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Family-owned Tag
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Family-owned',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom "Indulged" Button
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Indulged',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Bottom Icons Row
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Dislike Button (X)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () {
                      // Add action here
                    },
                  ),
                  // Middle Button (Expand/Collapse)
                  IconButton(
                    icon: const Icon(Icons.expand_more, color: Colors.white, size: 30),
                    onPressed: () {
                      // Add action here
                    },
                  ),
                  // Like Button (Checkmark)
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.white, size: 30),
                    onPressed: () {
                      // Add action here
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
