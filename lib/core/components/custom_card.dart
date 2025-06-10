import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
 CustomCard({super.key,required this.cardtitle, required this.price, required this.imageUrl, required this.favicon, required this.addcartIcon, this.onPressedCart, this.onPressedFav});

  String cardtitle;
  String price;
  String imageUrl;
  Icon favicon;
  Icon addcartIcon;
  void Function()? onPressedCart;
  void Function()? onPressedFav;



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
                Stack(
                  children:
                  [
                     Image.asset(
                    imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                    IconButton(
                      icon: favicon,
                      onPressed: onPressedFav,
                      color: Colors.white,
                    ),

                  ] 
                ),
                Text(
                  '${cardtitle}',
                   style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${price}',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed:onPressedCart , 
                      icon:addcartIcon,
                       ),
                  ],
                ),
              ],
            ),
          ),
         ),

      ],
    );
  }
}