import 'package:flutter/material.dart';
import 'package:shop/Provider/products.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import 'package:provider/provider.dart';
import './Provider/cart.dart';

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
          //here we use our provider class

          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          
            primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
            backgroundColor: Colors.white,
            primarySwatch: Colors.orange,
            accentColor: Colors.orangeAccent,
            textTheme: ThemeData.light().textTheme.copyWith(
                  body1: TextStyle(
                      color: Colors.white, fontFamily: 'Lato', fontSize: 15),
                  title: TextStyle(
                      fontFamily: 'Lato', fontSize: 22, color: Colors.white),
                )

            // textTheme: ThemeData.light().textTheme.copyWith(
            //       body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            //       body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            //       title: TextStyle(
            //         fontSize: 20,
            //         fontFamily: 'RobotoCondesed',
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),

            ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
