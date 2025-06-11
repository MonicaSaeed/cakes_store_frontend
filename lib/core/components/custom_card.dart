import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
 CustomCard({super.key,required this.cardtitle, required this.price, required this.imageUrl, required this.favicon, required this.addcartIcon, this.onPressedCart, this.onPressedFav});

  final String cardtitle;
  final String price;
  final String imageUrl;
  final IconData favicon;
  final IconData addcartIcon;
  final void Function()? onPressedCart;
  final void Function()? onPressedFav;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Card(
          elevation: 4,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children:
                  [
                Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.only(
                   top: 5, right: 8,
                 ),
                 child: Container(
                   padding: EdgeInsets.all(6),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: Colors.white,
                   ),
                   child: IconButton(
                     icon: Icon(
                       favicon,
                       size: 30,
                     ),
                      onPressed: onPressedFav,
                   ),
                 ),
               ),
              ] 
           ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 8),
            child: Text(
              cardtitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: onPressedCart,
                  icon: Icon(
                    addcartIcon,
                    color: Colors.teal,
                    size: 30,
                  ),
                ),
              ],
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