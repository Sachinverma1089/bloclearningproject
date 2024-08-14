import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/wishlist/bloc/wishlist_bloc_bloc.dart';
import 'package:myapp/features/wishlist/ui/wishlist_tile_widget.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishlistBlocBloc wishlistBlocBloc = WishlistBlocBloc();
  @override
  void initState() {
    super.initState();
    wishlistBlocBloc.add(WishlistInitialEvent()); // Initialize wishlist
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist Item"),
      ),
      body: BlocConsumer<WishlistBlocBloc, WishlistBlocState>(
        bloc: wishlistBlocBloc,
        listenWhen: (previous, current) => current is WishlistRemoveActionState,
        buildWhen: (previous, current) => current is! WishlistRemoveActionState,
        listener: (context, state) {
          if (state is WishlistRemoveActionState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Item Removed!")));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context, item) {
                    return WishlistTileWidget(
                        productDataModel: successState.wishlistItems[item],
                        wishlistBlocBloc: wishlistBlocBloc);
                  });

            default:
              return Container();
          }
        },
      ),
    );
  }
}
