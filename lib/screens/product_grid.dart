import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/products.dart';
import '../widgets/product_item.dart';

class ProductOverviewGrid extends StatelessWidget {
  final bool showFavs;
  ProductOverviewGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Products>(context);
//if showFavs = true it show favorite items
    final products = showFavs ? loadedProduct.favorite : loadedProduct.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(
            // products[index].id,
            // products[index].title,
            // products[index].imageUrl,

            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 2,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
}
