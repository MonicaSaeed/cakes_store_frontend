import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
 CustomCard({super.key,required this.cardtitle, required this.price, required this.imageUrl, required this.favicon, required this.addcartIcon, this.onPressedCart, this.onPressedFav, this.onPressedcard});

  final String cardtitle;
  final String price;
  final String imageUrl;
  final IconData favicon;
  final IconData addcartIcon;
  final void Function()? onPressedCart;
  final void Function()? onPressedFav;
  final void Function()? onPressedcard;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         GestureDetector(
          onTap: onPressedcard,
           child: Container(
            width: 200,
             height: 240,
             child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                     
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.all(4.0),
                     child: Container(
                      width: 40,
                       padding: EdgeInsets.all(1),
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: Colors.white,
                       ),
                       child: IconButton(
                         icon: Icon(
                           favicon,
                           size: 20,
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
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '\$$price',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          overflow:TextOverflow.ellipsis,
                        ),
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
           ),
         ),

      ],
    );
  }
}