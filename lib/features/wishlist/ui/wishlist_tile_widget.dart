import 'package:flutter/material.dart';
import 'package:myapp/features/home/models/home_product_data_model.dart';
import 'package:myapp/features/wishlist/bloc/wishlist_bloc_bloc.dart';

class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishlistBlocBloc wishlistBlocBloc;
  const WishlistTileWidget(
      {required this.productDataModel,
      super.key,
      required this.wishlistBlocBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.imageUrl))),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            productDataModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            productDataModel.category,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\₹" + productDataModel.price,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      wishlistBlocBloc.add(
                          WishlistProductRemoveFromWishlistEvent(
                              productDataModel: productDataModel));
                    },
                    icon: Icon(Icons.favorite),
                    color: Colors.teal,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
