import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/badge.dart';
import '../Provider/product.dart';
import '../widgets/product_item.dart';
import '../dummy_data.dart';
import '../screens/product_grid.dart';
import '../Provider/products.dart';
import '../Provider/cart.dart';

enum FilterOption {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  List<Product> loadedProduct = shopProducts;
  var _showOnlyFavorite = false;

  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: Theme.of(context).textTheme.title),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favorite) {
                  // productContainer.showFavoriteOnly();
                  _showOnlyFavorite = true;
                } else if (selectedValue == FilterOption.All) {
                  // productContainer.showAll();
                  _showOnlyFavorite = false;
                }
              });

              print(selectedValue);
            },
            
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOption.Favorite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOption.All,
              )
            ],
          ),

          //use Cart provider

          Consumer<Cart>(

            builder: (_, carData, ch) => Badge(
             color: Colors.red,
             child: ch,
               value: carData.itemCount.toString(),
            ),
             child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
          )
        ],
      ),
      body: ProductOverviewGrid(_showOnlyFavorite),
    );
  }
}
