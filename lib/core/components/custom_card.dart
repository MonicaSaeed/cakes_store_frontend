import 'package:cakes_store_frontend/core/components/rating_bar_widget.dart';
import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    super.key,
    required this.cardtitle,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.favicon,
    required this.addcartIcon,
    this.onPressedCart,

    this.onPressedFav,
    this.onPressedcard,
  });

  final String cardtitle;
  final String price;
  final String imageUrl;
  final double rating;
  final IconData favicon;
  final IconData addcartIcon;
  final void Function()? onPressedCart;
  final void Function()? onPressedFav;
  final void Function()? onPressedcard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedcard,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 8),
        child: Container(
          height: 550,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 50,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: Icon(favicon, size: 25),
                        onPressed: onPressedFav,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: SizedBox(
                  height: 50,
                  child: Text(
                    cardtitle,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      letterSpacing: 2,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: RatingBarWidget(rating: rating, reviewCount: 28),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '\$$price',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium?.copyWith(
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onPressedCart,
                      icon: Icon(
                        addcartIcon,
                        color: LightThemeColors.primary,
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
    );
  }
}
