part of 'wishlist_bloc_bloc.dart';

@immutable
abstract class WishlistBlocState {}

class WishlistBlocInitial extends WishlistBlocState {}

class WishlistSuccessState extends WishlistBlocState {
  final List<ProductDataModel> wishlistItems;

  WishlistSuccessState({required this.wishlistItems});
}

class WishlistRemoveActionState extends WishlistBlocState {}
