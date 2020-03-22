import 'package:flutter/material.dart';
import './Provider/products.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import 'package:provider/provider.dart';
import './Provider/cart.dart';
import './Provider/order.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './Provider/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //or use ChangeNotifierProvider.value
//return ChangeNotifierProvider.value(

    //here we use our provider class

    // create: (ctx) => Products(),

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (cts, auth, previousProducts) => Products(auth.token,
              previousProducts == null ? [] : previousProducts.items),
        ),
        //here we use our provider class

        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          update: (ctx, auth, previousOrders) => Order(
              auth.token, previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                    primaryTextTheme:
                        TextTheme(title: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.white,
                    primarySwatch: Colors.orange,
                    accentColor: Colors.orangeAccent,
                    textTheme: ThemeData.light().textTheme.copyWith(
                          body1: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato',
                              fontSize: 15),
                          title: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 22,
                              color: Colors.white),
                        )),
                home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
                routes: {
                  ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                  CartScreen.routeName: (ctx) => CartScreen(),
                  OrderScreen.routeName: (ctx) => OrderScreen(),
                  UserproductScreen.routeName: (ctx) => UserproductScreen(),
                  EditProductScreen.routeName: (ctx) => EditProductScreen(),
                },
              )),
    );
  }
}
