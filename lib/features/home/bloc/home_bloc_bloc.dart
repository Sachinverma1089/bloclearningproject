import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/data/cart_items.dart';
import 'package:myapp/data/grocery_data.dart';
import 'package:myapp/features/home/models/home_product_data_model.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeBlocState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));

    try {
      final products = GroceryData.groceryProducts.map((e) {
        return ProductDataModel(
          id: e['id'],
          name: e['name'],
          category: e['category'],
          price: e['price'],
          imageUrl: e['imageUrl'],
          isClickedWishButton: e['isClickedWishButton']??false,
          isClickedCartButton: e['isClickedCartButton']??false,
        );
      }).toList();

      emit(HomeLoadedSuccessState(products: products));
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeBlocState> emit) {
    emit(HomeNavigateToWishListPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeBlocState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event,
      Emitter<HomeBlocState> emit) {
    event.clickedProduct.isClickedWishButton =
        !event.clickedProduct.isClickedWishButton;

    if (event.clickedProduct.isClickedWishButton) {
      wishlistItems.add(event.clickedProduct);
      emit(HomeProductItemWhishlistedActionState());
    } else {
      
      // Remove from wishlist after delay
      wishlistItems.remove(event.clickedProduct);
      emit(HomeProductItemUnWhishlistedActionState());
    }

    // Emit the updated list to refresh the UI
    emit(HomeLoadedSuccessState(products: [
      ...GroceryData.groceryProducts.map((e) => ProductDataModel(
            id: e['id'],
            name: e['name'],
            category: e['category'],
            price: e['price'],
            imageUrl: e['imageUrl'],
            isClickedWishButton:
                wishlistItems.any((item) => item.id == e['id']),
            isClickedCartButton: cartItems.any((item) => item.id == e['id']),
          ))
    ]));
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeBlocState> emit) {
    // Toggle the cart state
    event.clickedProduct.isClickedCartButton =
        !event.clickedProduct.isClickedCartButton;

    if (event.clickedProduct.isClickedCartButton) {
      cartItems.add(event.clickedProduct);
      emit(HomeProductItemCartedlistedActionState());
    }

    // Emit the updated list to refresh the UI
    emit(HomeLoadedSuccessState(products: [
      ...GroceryData.groceryProducts.map((e) => ProductDataModel(
            id: e['id'],
            name: e['name'],
            category: e['category'],
            price: e['price'],
            imageUrl: e['imageUrl'],
            isClickedWishButton:
                wishlistItems.any((item) => item.id == e['id']),
            isClickedCartButton: cartItems.any((item) => item.id == e['id']),
          ))
    ]));
  }
}
