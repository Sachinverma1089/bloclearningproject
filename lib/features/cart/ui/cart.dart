import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/cart/bloc/cart_bloc_bloc.dart';
import 'package:myapp/features/cart/ui/cart_tile_widget.dart';
import 'package:myapp/features/home/bloc/home_bloc_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBlocBloc cartBlocBloc = CartBlocBloc();
  @override
  void initState() {
    cartBlocBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart Items"),
        ),
        body: BlocConsumer<CartBlocBloc, CartBlocState>(
          bloc: cartBlocBloc,
          listenWhen: (previous, current) => current is CartRemoveActionState,
          buildWhen: (previous, current) => current is! CartRemoveActionState,
          listener: (context, state) {
            if (state is CartRemoveActionState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Item Removed!")));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartSuccessState:
                final successState = state as CartSuccessState;
                return ListView.builder(
                    itemCount: successState.cartItems.length,
                    itemBuilder: (context, item) {
                      return CartTileWidget(
                          cartBlocBloc: cartBlocBloc,
                          productDataModel: successState.cartItems[item]);
                    });

              default:
            }
            return Container();
          },
        ));
  }
}
