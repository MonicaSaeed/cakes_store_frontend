import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
 CustomCard({super.key,required this.cardtitle, required this.carddescription, required this.imageUrl});

  String cardtitle;
  String carddescription;
  String imageUrl;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         
         Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Text(
                  '${cardtitle}',
                   style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${carddescription}',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
         ),

      ],
    );
  }
}