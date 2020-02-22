import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'ProductDetailScreen';
  // final String title;
  // ProductDetailScreen(this.title);

  @override
  Widget build(BuildContext context) {
    final ProductId = ModalRoute.of(context).settings.arguments as String;

    final loadedProduct = Provider.of<Products>(
      context,
      listen: false, //by adding this it shows that widget cannot rebuild
    ).findById(ProductId);

    //  final loadedProduct = Provider.of<Products>(context).items.firstWhere((prod)=>prod.id==ProductId);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title:
            Text(loadedProduct.title, style: Theme.of(context).textTheme.title),
        centerTitle: true,
      ),

      // appBar: CupertinoNavigationBar(
      //   middle:
      //       Text(loadedProduct.title, style: Theme.of(context).textTheme.title),
      // ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text('${loadedProduct.title}',
                      style: TextStyle(color: Colors.black,fontFamily: 'Anton-Regular',fontSize: 22)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${loadedProduct.description}',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black,fontFamily: 'Lato'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                       
                        'Price : ',
                         textAlign:TextAlign.left,
                        
                        style: TextStyle(color: Colors.black,fontFamily: 'Lato',fontSize: 20),
                      ),
                      Text(
                       
                        '\$${loadedProduct.price}',
                         textAlign:TextAlign.left,
                        
                        style: TextStyle(color: Colors.black,fontFamily: 'Lato',fontSize: 20,fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
