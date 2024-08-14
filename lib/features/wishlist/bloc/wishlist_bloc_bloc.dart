import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/data/cart_items.dart';
import 'package:myapp/features/home/models/home_product_data_model.dart';

part 'wishlist_bloc_event.dart';
part 'wishlist_bloc_state.dart';

class WishlistBlocBloc extends Bloc<WishlistBlocEvent, WishlistBlocState> {
  WishlistBlocBloc() : super(WishlistBlocInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistProductRemoveFromWishlistEvent>(
        wishlistProductRemoveFromWishlistEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistBlocState> emit) {
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistProductRemoveFromWishlistEvent(
      WishlistProductRemoveFromWishlistEvent event,
      Emitter<WishlistBlocState> emit) {
        wishlistItems.remove(event.productDataModel);
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
    emit(WishlistRemoveActionState());
      }
      
}
