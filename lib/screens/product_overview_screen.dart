import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
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
  var _init=true;
  var _isLoading=false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_init){
      setState(() {
        _isLoading=true;
      });
      Provider.of<Products>(context).fetchProduct().then((_){
        setState(() {
          _isLoading=false;
        });
      });

    }
    _init=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
         iconTheme: new IconThemeData(color: Colors.white),
        title: Text('Home', style: Theme.of(context).textTheme.title),
        centerTitle: true,
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, carData, ch) => Badge(
              color: Colors.red,
              child: ch,
              value: carData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),

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
        ],
      ),
      body:_isLoading ? Center(child: CircularProgressIndicator(),) : ProductOverviewGrid(_showOnlyFavorite),
      drawer: AppDrawer(),
    );
  }
}
