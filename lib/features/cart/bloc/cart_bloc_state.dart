part of 'cart_bloc_bloc.dart';

@immutable
abstract class CartBlocState {}

abstract class CartBlocActionState {}

class CartBlocInitial extends CartBlocState {}

class CartSuccessState extends CartBlocState {
  final List<ProductDataModel> cartItems;

  CartSuccessState({required this.cartItems});
}

class CartRemoveActionState extends CartBlocState {}
