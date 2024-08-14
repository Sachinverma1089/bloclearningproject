part of 'wishlist_bloc_bloc.dart';

@immutable
abstract class WishlistBlocEvent {}

class WishlistInitialEvent extends WishlistBlocEvent {}

class WishlistProductRemoveFromWishlistEvent extends WishlistBlocEvent {
  final ProductDataModel productDataModel;

  WishlistProductRemoveFromWishlistEvent({required this.productDataModel});

}
