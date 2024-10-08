part of 'home_bloc_bloc.dart';

@immutable
abstract class HomeBlocState {}

abstract class HomeActionState extends HomeBlocState {}

class HomeBlocInitial extends HomeBlocState {}

class HomeLoadingState extends HomeBlocState {}

class HomeLoadedSuccessState extends HomeBlocState {
  final List<ProductDataModel> products;
  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeBlocState {}

class HomeNavigateToWishListPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductItemWhishlistedActionState extends HomeActionState {}

class HomeProductItemCartedlistedActionState extends HomeActionState {}

class HomeProductItemUnWhishlistedActionState extends HomeActionState {}

class HomeProductItemUnCartedlistedActionState extends HomeActionState {}
