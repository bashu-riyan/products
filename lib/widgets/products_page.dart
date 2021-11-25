import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:products/modal/products.dart';
import 'package:products/modal/productAPI.dart';
import 'toppart.dart';
import 'product_detail.dart';


Color firstColor = const Color(0xFFF47D15);
Color secondColor = const Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFFF37918),
  // todo "fontFamily impliment"
);

class ProductsPage extends StatefulWidget {
  bool listORgrid = true;
  String selectedItem = "All";
  List<dynamic> catagoryProduct = [];

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late List<ProductData> products;
  bool loading = true;
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future<void> getProducts() async {
    products = await ProductApi.getProductApi();
    setState(() {
      loading = false;
    });
  }

  void getCatagorizedProducts(String match) {
    setState(() {
      widget.catagoryProduct = [];

      if (match == "All") {
        for (int i = 0; i <= products.length - 1; i++) {
          widget.catagoryProduct.add(products[i]);
        }
      } else {
        for (int i = 0; i <= products.length - 1; i++) {
          if (products[i].category == match) {
            widget.catagoryProduct.add(products[i]);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopPart(),
            Container(
              color: Color(0xffF0F0F3),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton(
                      onSelected: (value) {
                        List<String> popItemList = [
                          'All',
                          "men's clothing",
                          "women's clothing",
                          "electronics",
                          "jewellery",
                        ];
                        switch (value) {
                          case 0:
                            {
                              // statements;
                              widget.selectedItem = popItemList[0];
                            }
                            break;

                          case 1:
                            {
                              //statements;
                              widget.selectedItem = popItemList[1];
                            }
                            break;
                          case 2:
                            {
                              //statements;
                              widget.selectedItem = popItemList[2];
                            }
                            break;
                          case 3:
                            {
                              //statements;
                              widget.selectedItem = popItemList[3];
                            }
                            break;
                          case 4:
                            {
                              //statements;
                              widget.selectedItem = "jewelery";
                            }
                            break;
                        }
                        getCatagorizedProducts(widget.selectedItem);
                        setState(() {});
                      },
                      itemBuilder: (context) => <PopupMenuItem<int>>[
                        PopupMenuItem(
                          child: Text(
                            "All",
                            style: TextStyle(color: Colors.black54),
                          ),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text(
                            "men's clothing",
                            style: TextStyle(color: Colors.black54),
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text(
                            "women's clothing",
                            style: TextStyle(color: Colors.black54),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(
                            "electronics",
                            style: TextStyle(color: Colors.black54),
                          ),
                          value: 3,
                        ),
                        PopupMenuItem(
                          child: Text(
                            "jewellery",
                            style: TextStyle(color: Colors.black54),
                          ),
                          value: 4,
                        )
                      ],
                      child: Row(
                        children: [
                          Text(widget.selectedItem == "jewelery"? "jewellery" :widget.selectedItem),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.black54,
                            size: 29.0,
                          )
                        ],
                      ),
                    ),
                    FlatButton(
                      minWidth: 9.0,
                      onPressed: () {
                        setState(() {
                          widget.listORgrid = !widget.listORgrid;
                        });
                      },
                      child: Icon(
                        widget.listORgrid ? Icons.list : Icons.apps,
                        size: 33.0,
                        color: Color(0xFFF47D15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                color: Color(0xffF0F0F3),
                child: loading
                    ? Center(child: const CircularProgressIndicator(
                  color: Color(0xFFF47D15),
                ))
                    : Container(
                        child: widget.listORgrid
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        crossAxisCount: 2),
                                itemCount: widget.selectedItem == "All"
                                    ? products.length
                                    : widget.catagoryProduct.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          color: Colors.white),
                                      child: ListTile(
                                        onTap: () {
                                          if (widget.selectedItem == "All") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                          image: products[index]
                                                              .image,
                                                          title: products[index]
                                                              .title,
                                                          price: products[index]
                                                              .price,
                                                          Description:
                                                              products[index]
                                                                  .description,
                                                          Rating: products[
                                                                  index]
                                                              .rate,
                                                          count: products[index]
                                                              .count)),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                          image: widget
                                                              .catagoryProduct[
                                                                  index]
                                                              .image,
                                                          title: widget
                                                              .catagoryProduct[
                                                                  index]
                                                              .title,
                                                          price: widget
                                                              .catagoryProduct[
                                                                  index]
                                                              .price,
                                                          Description: widget
                                                              .catagoryProduct[
                                                                  index]
                                                              .description,
                                                          Rating: widget
                                                              .catagoryProduct[
                                                                  index]
                                                              .rate,
                                                          count: widget
                                                              .catagoryProduct[
                                                                  index]
                                                              .count)),
                                            );
                                          }
                                        },
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              Image.network(
                                                widget.selectedItem == "All"
                                                    ? products[index].image
                                                    : widget
                                                        .catagoryProduct[index]
                                                        .image,
                                                width: 215.0,
                                                height: 117.0,
                                              ),
                                              Text(
                                                "${widget.selectedItem == "All" ? "${products[index].title.substring(0, 14)}..." : widget.catagoryProduct[index].title.substring(0, 14)}...",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.0),
                                              ),
                                              Text(
                                                "\$${widget.selectedItem == "All" ? products[index].price : widget.catagoryProduct[index].price}",
                                                style: TextStyle(
                                                  color: Color(0xFFF47D15),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                })
                            : ListView.builder(
                                itemCount: widget.selectedItem == "All"
                                    ? products.length
                                    : widget.catagoryProduct.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    child: ListTile(
                                      onTap: () {
                                        if (widget.selectedItem == "All") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetails(
                                                        image: products[index]
                                                            .image,
                                                        title: products[index]
                                                            .title,
                                                        price: products[index]
                                                            .price,
                                                        Description:
                                                            products[index]
                                                                .description,
                                                        Rating: products[index]
                                                            .rate,
                                                        count: products[index]
                                                            .count)),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetails(
                                                        image: widget
                                                            .catagoryProduct[
                                                                index]
                                                            .image,
                                                        title: widget
                                                            .catagoryProduct[
                                                                index]
                                                            .title,
                                                        price: widget
                                                            .catagoryProduct[
                                                                index]
                                                            .price,
                                                        Description: widget
                                                            .catagoryProduct[
                                                                index]
                                                            .description,
                                                        Rating: widget
                                                            .catagoryProduct[
                                                                index]
                                                            .rate,
                                                        count: widget
                                                            .catagoryProduct[
                                                                index]
                                                            .count)),
                                          );
                                        }
                                      },
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [

                                          Image.network(
                                            widget.selectedItem == "All"
                                                ? products[index].image
                                                : widget.catagoryProduct[index]
                                                    .image,
                                            width: 105.0,
                                            height: 110.0,
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${widget.selectedItem == "All" ? products[index].title.substring(0, 15) : widget.catagoryProduct[index].title.substring(0, 15)}...",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0),
                                              ),
                                              SizedBox(
                                                height: 9.0,
                                              ),
                                              Text(
                                                "\$${widget.selectedItem == "All" ? products[index].price : widget.catagoryProduct[index].price}",
                                                style: TextStyle(
                                                  color: Color(0xFFF47D15),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text(
                                                  "Rating: ${widget.selectedItem == "All" ? products[index].rate : widget.catagoryProduct[index].rate}")
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
