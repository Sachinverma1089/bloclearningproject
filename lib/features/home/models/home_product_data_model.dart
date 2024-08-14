class ProductDataModel {
  final String id;
  final String name;
  final String category;
  final String price;
  final String imageUrl;
  bool isClickedWishButton;
  bool isClickedCartButton;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.isClickedWishButton=false,
    this.isClickedCartButton=false,
  });
}
